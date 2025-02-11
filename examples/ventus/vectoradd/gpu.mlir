module attributes {
  llvm.data_layout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1", 
  llvm.target_triple = "riscv32",
  gpu.container_module
} {
  gpu.module @kernels {
    func.func @vectorAdd(
      %arg0: memref<1024xf32>,          
      %arg1: memref<1024xf32>   
    ) {
      %idx = gpu.global_id x 
      %a = memref.load %arg0[%idx] : memref<1024xf32>
      %b = memref.load %arg1[%idx] : memref<1024xf32>
      %sum = arith.addf %a, %b : f32
      memref.store %sum, %arg0[%idx] : memref<1024xf32>
      func.return
    }
  }
}
