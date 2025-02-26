# 从 Triton GPU IR 到 Triton LLVM IR

## 工作目录
ai-benchmark/examples/matmul

## 依赖版本
- triton 的 commit hash 为: `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`。
- llvm-project 的 commit hash 为: `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`（具体在 triton 项目的 `cmake/llvm-hash.txt` 中可以找到）。

## 具体步骤

### 生成 Triton GPU IR 的中间表示
我们使用 `matmul.py` 作为样例来生成 `matmul.ttgir` 文件, `matmul.py`的源代码如下：
```python
from torch import Tensor
import torch
import triton
import triton.language as tl
import triton.compiler as tc

@triton.jit
def matmul_kernel(
        a_ptr, b_ptr, c_ptr, 
        M, N, K, 
        BM: tl.constexpr, BN: tl.constexpr, BK: tl.constexpr,
        GROUP_SIZE: tl.constexpr
    ):
    """
    v2 版本的向量化矩阵相乘, 加了 L2 优化
    """
    pid = tl.program_id(axis=0)
    num_Ci = tl.cdiv(M, BM) # 行方向的块数
    num_Cj = tl.cdiv(N, BN) # 列方向的块数

    num_group_blocks = GROUP_SIZE*num_Cj # 一组包含的程序数
    pid_group_id = pid // num_group_blocks # 所在组的序号
    pid_group_loc = pid % num_group_blocks # 所在组中的位置(序号)
    # 组相当于对行再进行一次分块?
    group_first_row = pid_group_id * GROUP_SIZE
    group_size_cur = min(num_Ci - group_first_row, GROUP_SIZE)
    # 相当于 mask, 不过看起来怪怪的, 除非是最后一个组否则都应该是 GROUP_SIZE
    
    pid_Ci = group_first_row + (pid_group_loc % group_size_cur)
    # 这是因为同一组内块的创建是列主序的
    pid_Cj = pid_group_loc // group_size_cur

    off_Ai = pid_Ci*BM + tl.arange(0, BM)
    off_Bj = pid_Cj*BN + tl.arange(0, BN)
    mask_Ai = off_Ai < M
    mask_Bj = off_Bj < N

    C_batch = tl.zeros((BM, BN), dtype=tl.float32)
    for b in tl.range(0, K, BK):
        off_Aj = b + tl.arange(0, BK)
        off_Bi = b + tl.arange(0, BK)
        off_Aij = off_Ai[:, None]*K + off_Aj[None, :]
        off_Bij = off_Bi[:, None]*N + off_Bj[None, :]
        mask_Aij = mask_Ai[:, None] & (off_Aj<K)[None, :]
        mask_Bij = mask_Bj[None, :] & (off_Bi<K)[:, None]
        
        A_batch = tl.load(off_Aij+a_ptr, mask_Aij)
        B_batch = tl.load(off_Bij+b_ptr, mask_Bij)
        C_batch += tl.dot(A_batch, B_batch)
    
    off_Cij = off_Ai[:, None]*N + off_Bj[None, :]
    mask_Cij = mask_Ai[:, None] & mask_Bj[None, :]

    tl.store(off_Cij+c_ptr, C_batch, mask_Cij)

def matmul_triton(A: Tensor, B:Tensor) -> Tensor:
    assert A.is_cuda and B.is_cuda
    M, K = A.shape
    K_1, N = B.shape
    assert K==K_1, "Shape Error!"
    C = torch.empty((M, N), device='cuda')
    grid = lambda meta: (
        (triton.cdiv(M, meta['BM'])*(triton.cdiv(N, meta['BN']))), 
    )
    matmul_kernel[grid](A, B, C, M, N, K, 32, 32, 32, 32)
    return C

if __name__ == '__main__':
    src = tc.ASTSource(
    	fn=matmul_kernel,
    	constants={"BM": 32, "BN": 32, "BK": 32, "GROUP_SIZE": 32},
    	signature="*fp32,*fp32,*fp32,i32,i32,i32",
    )
    ret = triton.compile(src)
    out_format = ['ttir', 'ttgir', 'llir']
    for fmt in out_format:
        with open("matmul."+fmt, 'w') as f:
            f.write(ret.asm[fmt])

```

首先运行该 Python 脚本:
```
python matmul.py
```
*注意* : 运行该脚本其实会生成三个文件 `matmul.ttir`,`matmul.ttgir`, `matmul.llir`, 只不过我们只用到了 `matmul.ttgir`

可以通过开启以下环境变量来查看详细的信息
```
MLIR_ENABLE_TIMING=1 MLIR_ENABLE_DUMP=1 python matmul.py 2> pass.log
```
*注意* : 上述命令可能会没有输出, 这是因为 triton 将分析过程缓存了下来, 此时需要删除 triton 的缓存来让其重新分析, 其缓存在 `~/.triton` 目录下.

### 分析 Pass
在 `/triton/third_party/nvidia/backend/compiler.py` 的 `make_llir` 函数中或 `pass.log` 的最后, 我们可以发现从 `ttgir` 到 `llir` 涉及的 Pass:
- DecomposeUnsupportedNVIDIAConversions
- TritonGPUCombineTensorSelectAndIf
- SCFToControlFlow
- ConvertIndexToLLVMPass
- AllocateSharedMemory
- TritonGPUGlobalScratchAllocationPass
- ConvertTritonGPUToLLVM
- ConvertNVGPUToLLVM
- ArithToLLVMConversionPass
- Canonicalizer
- CSE
- DominanceInfo
- SymbolDCE

其大部分 Pass (除了 DominanceInfo)均可以在 `triton-opt-option-list.txt` 中找到对应的选项.

*注意* : `triton-opt-option-list.txt` 由命令 `triton-opt --help-list > triton-opt-option-list.txt` 生成.

依次我们可以写出 `Makefile` 文件.

### 生成 Triton LLVM IR
在 `make` 之前需要设置环境变量 `TRITON_BUILD` 和 `LLVM_BUILD`.然后使用以下命令, 来对 Triton GPU IR 做手动下降:
```
make matmul.llir
```
至此, 我们得到了手动下降的 LLVM IR Dialect 时的中间表示 (`matmul.llir`).
