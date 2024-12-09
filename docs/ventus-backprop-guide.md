# ventus-backprop 运行指南

## 目录结构
```
ventus-backprop
├── backprop_custom_translate.ll 
├── backprop_official_import_llvm.mlir
├── backprop_official.ll
├── driver
│   ├── CMakeLists.txt
│   ├── include
│   │   ├── ventus.h
│   │   └── vt_utils.h
│   ├── test.cpp
│   └── ventus.cpp
├── Makefile
└── translate
    ├── CMakeLists.txt
    └── translate.cc
```
其中:
- `Makefile` 自动化构建脚本, 仿照 `example/ventus-vectoradd/Makefile` .
- `driver` spike 测试工具, 来自 `ventus-gpgpu-isa-simulator` 项目下的 `gpgpu-testcase/driver`, 但修改过 `CMakeLists.txt`, 使得 `SPIKE_SRC_DIR` 和 `SPIKE_TARGET_DIR` 不必从环境变量中获取.
- `translate` MLIR->LLVM IR 自定义转换工具, 其在完成 `mlir-translate` 作用的同时对转换后的 LLVM IR 添加必要的属性和元信息.
- `backprop_official.ll` 是 `gpu-rodinia` 项目下的 `/opencl/backprop/backprop_kernel.cl` 经过官方工具链转换得到的 LLVM IR 文件.
- `backprop_official_import_llvm.mlir` 是 `backprop_official.ll` 经过 `mlir-translate --import-llvm` 得到的 MLIR 文件.
- `backprop_custom_translate.ll` 是 `backprop_official_import_llvm.mlir` 经过自定义工具 `translate` 转换得到的 LLVM IR 文件, 该文件相比 `backprop_official.ll`, 仅添加了部分必要的函数属性和元信息, 使得其生成的汇编与 `backprop_official.ll` 生成的汇编仅有注释上的不同(TODO: 目前发现官方工具链得到汇编会在函数调用后添加 `@plt`, 目前尚不清楚是什么原因).
## 编译工具
为了使自定义工具 `translate` 能够识别ventus_kernel 函数, 需要在MLIR 中定义相应的调用约定(Calling Convention). 由于原有的llvm-project 中尚未包含 ventus kernel 相关的调用约定, 我参考了spir_kernel 的实现方式, 在 `llvm-project/mlir/include/mlir/Dialect/LLVMIR/LLVMEnums.td` 文件中添加了ventus kernel 的调用约定.

这部分更改已写入到 `patch/llvm-project-0001-Add-CallingConvention-of-Ventus-kernel.patch`, 使用以下命令来应用该 `patch` :
```
cd /path/to/your/llvm-project/
git apply /path/to/your/triton-benchmark/patch/llvm-project-0001-Add-CallingConvention-of-Ventus-kernel.patch
```

在编译之前请在 `Makefile` 中修改相关的路径, 然后编译工具:
```
make make-translate make-spike-test
```
## 查看汇编差异
若想要查看自定义工具链和官方工具链生成的汇编差异, 运行如下命令:
```
make view-diff
```
使用别的 diff 工具可以自行更改 `Makefile` 中的 `DIFF_TOOL` 变量, 默认为 vimdiff.
## 运行测试
测试工具使用的是 `ventus-gpgpu-isa-simulator` 项目下的 `gpgpu-testcase/driver`, 但这个工具好像不会验证正确性.

首先获取 `backprop.riscv` ELF 文件:
```
make get-backprop-riscv
```

然后运行测试:
```
make run-backprop-riscv
```
