# .mlir -> .riscv 编译原理

以 `backprop.mlir` 为例子，梳理编译流以及模拟程：

- MLIR 代码优化（mlir-opt） → 生成 LLVM Dialect (backprop_llvm_dialect.mlir)
- LLVM Dialect 转换为 LLVM IR（mlir-translate） → 生成 LLVM IR (backprop.ll)
- LLVM IR 编译成目标文件（llc） → 生成目标文件 (backprop.o)
- 链接生成 RISC-V 可执行文件（ld.lld） → 生成 backprop.riscv
- 运行 backprop.riscv 在 Ventus 模拟器上

## MLIR -> LLVM Dialect 

该 MLIR 代码使用了 memref 和 arith 两个方言，并通过 gpu.barrier 进行 GPU 线程同步。
- `memref`：用于定义和操作张量（dY、A、dW）
- `arith`：用于执行整数和浮点运算，如索引计算和矩阵元素乘法
- `gpu.barrier`：用于确保所有线程在存储计算结果前完成计算

```bash
${LLVM_DIALECT_FILE}: ${MLIR_FILE}
	@${MLIR_OPT} $< --pass-pipeline="builtin.module(convert-func-to-llvm{use-bare-ptr-memref-call-conv=true},convert-scf-to-cf,convert-cf-to-llvm,convert-arith-to-llvm,finalize-memref-to-llvm,reconcile-unrealized-casts)" -o $@
```
这里调用 `mlir-opt` 执行一系列 Pass：
- `convert-func-to-llvm`：转换函数调用方式，使其兼容 LLVM
- `convert-scf-to-cf`：将 scf.for 结构转换为 cf 结构
- `convert-cf-to-llvm`：转换 cf 控制流结构到 LLVM Dialect
- `convert-arith-to-llvm`：算术运算转换
- `finalize-memref-to-llvm`：处理 MemRef 到 LLVM 指针的转换
- `reconcile-unrealized-casts`：处理 Unrealized Casts（未实现的类型转换）

## LLVM Dialect -> LLVM IR

```bash
${LL_FILE}: ${LLVM_DIALECT_FILE}
	@${MLIR_TRANSLATE} -mlir-to-llvmir $< -o $@
	@sed -i 's/define void @backprop/define ventus_kernel void @backprop/' $@
```

- `mlir-translate` 将 `MLIR Dialect` 转换为标准 `LLVM IR`
- `sed` 命令为函数添加 `ventus_kernel` 前缀， 便于模拟器识别

### ***mlir-translate 拓展***  
在 MLIR Dialect 里，`gpu.barrier` 还是 `MLIR` 操作，`在backprop.ll` 里面被替换成 `call void @llvm.riscv.ventus.barrier(i32 1)`。
- 当 `mlir-translate` 遇到 `gpu.barrier` 时，调用 `getOrCreateVentusBarrier`
- 在 `llvm::Module` 里创建一个新的 `@llvm.riscv.ventus.barrier` 函数
- 具体实现详见 `/mlir/lib/Target/LLVMIR/Dialect/GPU/GPUToLLVMIRTranslation.cpp` 和 `examples/patch/ventus/llvm-0002`


## LLVM IR -> .obj

```bash
${OBJ_FILE}: ${LL_FILE}
	@${LLC} -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj $< -o $@
```
llc 用于将 LLVM IR 转换为 RISC-V 目标代码：
- -mtriple=riscv32：目标架构为 32 位 RISC-V
- -mcpu=ventus-gpgpu：针对 Ventus-GPGPU 进行优化

## .obj -> .riscv

```bash
${OUTPUT_FILE}: ${OBJ_FILE}
	@${LD} -o $@ -T ${VENTUS_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld \
	$< ${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o \
	-L ${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init backprop
```
这里使用 `LLVM LLD` 链接器生成 RISC-V 可执行文件。


