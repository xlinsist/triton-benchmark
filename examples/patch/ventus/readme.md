# LLVM MLIR Translation Project

Base LLVM-PROJECT commit: `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`

## Patches

### 0001-ventus-add-ventus_kernel-for-opencl-kernel-function.patch
- Added mlir-translate support for LLVM IR to MLIR LLVM Dialect translation
  ```bash
  mlir-translate -import-llvm offical_kernel.ll -o import.mlir
  ```
- Added mlir-translate support for MLIR LLVM Dialect back to LLVM IR
  ```bash
  mlir-translate -mlir-to-llvmir import.mlir -o res.ll
  ```
### llvm-0002-mlir-translate-barrier.patch
- Apply the patch
  ```bash
  cd path-to-llvm_build
  ninja mlir-translate
  ```
### llvm-0003-driver_update.patch
- Modification on ventus-gpgpu-isa-simulator/gpgpu-testcase/driver
- Automating backprop mlir-to-riscv testing
### [TODO]some patches will be added in patch/ventus