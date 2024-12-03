# 从 Triton GPU IR 到 Triton LLVM IR

## 依赖版本
- triton 的 commit hash 为: 83cf4362bd87c74bf57e79a7e213b4301fa3f25c ;
- llvm-project 的 commit hash 为: a4c3683b665c6ac875b4821f5c6a881fdf5fef70 .

## 具体步骤

### 生成 Triton GPU IR 的中间表示
我们使用 `matmul.py` 作为样例来生成 `matmul.ttgir` 文件, 首先运行该 Python 脚本:
```
python matmul.py
```
*注意* : 运行该脚本其实会生成三个文件 `matmul.ttir`,`matmul.ttgir`, `matmul.ll`, 只不过我们只用到了 `matmul.ttgir`

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