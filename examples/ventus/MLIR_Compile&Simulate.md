# MLIR Compilation and Simulation

## Prerequisite
所有编译工具均来自 LLVM 和 Ventus GPGPU 相关工具链
- `mlir-opt`：优化和转换 MLIR 文件
- `mlir-translate`：将 MLIR 代码转换为 LLVM IR
- `llc`：LLVM IR 转换为 RISC-V 汇编
- `ld.lld`：LLVM 链接器，生成最终的 RISC-V 可执行文件
- `spike_test`：Ventus GPGPU ISA 模拟器，用于执行 RISC-V 二进制文件

环境变量
```bash
export VENTUS_INSTALL_PREFIX=/your path/llvm-project/install
export PATH=${VENTUS_INSTALL_PREFIX}/bin:$PATH
export SPIKE_SRC_DIR=/your path/ventus-gpgpu-isa-simulator
export SPIKE_TARGET_DIR=${VENTUS_INSTALL_PREFIX}
export LD_LIBRARY_PATH=$SPIKE_TARGET_DIR/lib:$LD_LIBRARY_PATH
```

## 编译
以 `backprop.mlir` 为例子

首先完成所有相关编译
```bash
cd path-to-backprop
make get-backprop-riscv # 自动化生成riscv二进制
make objdump # 反汇编
make pass-to-driver # 将test.cpp 和 backprop.riscv传入driver，等待模拟测试
```

## 模拟
```bash
cd path-to-_driver
make all # 清理，cmake配置, 编译
make run # 模拟
```

终端的正确输出  
=== dW Output (4x4 Matrix) ===  
001.00 000.00 000.00 000.00   
000.00 006.00 000.00 000.00   
000.00 000.00 011.00 000.00   
000.00 000.00 000.00 016.00 

