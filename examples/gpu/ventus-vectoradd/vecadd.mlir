module attributes { 
 llvm.data_layout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1", 
 llvm.target_triple = "riscv32"
} {
 func.func private @_Z13get_global_idj(i32) -> i32

 // With use-bare-ptr-memref-call-conv=true, memrefs are lowered to simple pointers,
 // so the size '1024' is only used for compile-time checking and doesn't affect 
 // the generated LLVM IR
 func.func @vectorAdd(
   %arg0: memref<1024xf32, 1>, // A array, also stores result
   %arg1: memref<1024xf32, 1>  // B array
 ){
   %c0 = arith.constant 0 : i32
   %idx_i32 = func.call @_Z13get_global_idj(%c0) : (i32) -> i32
   %idx = arith.index_cast %idx_i32 : i32 to index
   
   %val0 = memref.load %arg0[%idx] : memref<1024xf32, 1>
   %val1 = memref.load %arg1[%idx] : memref<1024xf32, 1>
   %sum = arith.addf %val0, %val1 : f32
   memref.store %sum, %arg0[%idx] : memref<1024xf32, 1>
   
   return
 }
}
