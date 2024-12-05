# vector-add lowering步骤

## add_kernel.ttgir获取
搭建好llvm与triton环境，并运行示例01-vector-add.py，将获得add_kernel.ttir、add_kernel.ttgir、add_kernel.llir等
```
$ python 01-vector-add.py
```

## 从Triton GPU dialect到LLVM dialect
利用triton-opt，将add_kernel.ttgir下降到add_kernel.mlir
```
$ make  ttgir_to_llvmdialect
```

## 从LLVM dialect到LLVM IR
利用mlir-translate，将add_kernel.mlir下降到add_kernel.llir
```
$ make  llvmdialect_to_llvmir
```

至此我们完成了从Triton GPU dialect到LLVM IR的手动下降过程
