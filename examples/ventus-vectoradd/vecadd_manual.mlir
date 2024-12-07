// Manually written

module attributes { 
  llvm.data_layout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1", 
  llvm.target_triple = "riscv32"
} {
  llvm.func @_Z13get_global_idj(i32) -> i32 

  llvm.func @vecadd(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>)
    attributes { ventus.kernel } {
    %c0 = llvm.mlir.constant(0 : i32) : i32
    %idx = llvm.call @_Z13get_global_idj(%c0) : (i32) -> i32
    %ptr0 = llvm.getelementptr %arg0[%idx] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %val0 = llvm.load %ptr0 : !llvm.ptr<1> -> f32
    %ptr1 = llvm.getelementptr %arg1[%idx] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %val1 = llvm.load %ptr1 : !llvm.ptr<1> -> f32
    %sum = llvm.fadd %val0, %val1 : f32
    %ptr2 = llvm.getelementptr %arg2[%idx] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    llvm.store %sum, %ptr2 : f32, !llvm.ptr<1>
    llvm.return
  }
}
