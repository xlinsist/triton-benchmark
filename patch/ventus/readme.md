# LLVM MLIR Translation Support

## Overview
Added support for LLVM IR to MLIR translation and back to LLVM IR, with successful RISC-V binary generation.

## Base LLVM Version
Based on LLVM commit:
```a4c3683b665c6ac875b4821f5c6a881fdf5fef70```

## Supported Features
1. LLVM IR to MLIR LLVM Dialect:
    ```bash
    mlir-translate -import-llvm offical_kernel.ll -o import.mlir 
    ```  
<br>

2. MLIR LLVM Dialect back to LLVM IR:
    ```bash
    mlir-translate -mlir-to-llvmir import.mlir -o res.ll
    ```
<br>

3. Generated RISC-V binary from translated LLVM IR res.ll is executable

