module attributes {
  llvm.data_layout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1",
  llvm.target_triple = "riscv32"
} {
  func.func private @_Z13get_global_idj(i32) -> i32

  func.func @backprop(
    %dY: memref<16xf32, 1>,   // 1D storage of a 4x4 error gradient matrix
    %A: memref<16xf32, 1>,    // 1D storage of a 4x4 activation matrix
    %dW: memref<16xf32, 1>    // 1D storage of a 4x4 result matrix
  ) {
    // Get the global thread ID (assuming each thread processes one matrix element)
    %c0 = arith.constant 0 : i32
    %c4 = arith.constant 4 : i32
    %idx_i32 = func.call @_Z13get_global_idj(%c0) : (i32) -> i32

    // Convert the linear index to 2D coordinates: row = idx / 4, col = idx % 4
    %row_i32 = arith.divsi %idx_i32, %c4 : i32
    %col_i32 = arith.remsi %idx_i32, %c4 : i32

    // Convert to index type
    %row = arith.index_cast %row_i32 : i32 to index
    %col = arith.index_cast %col_i32 : i32 to index

    // Convert constant %c4 to index type
    %c4_index = arith.index_cast %c4 : i32 to index

    // Compute the corresponding 1D linear index from 2D coordinates (theoretically the same as the original idx)
    %row_mul = arith.muli %row, %c4_index : index
    %linear_idx = arith.addi %row_mul, %col : index

    // Load the corresponding elements from dY and A, then compute the gradient update
    %dY_val = memref.load %dY[%linear_idx] : memref<16xf32, 1>
    %A_val = memref.load %A[%linear_idx] : memref<16xf32, 1>
    %update = arith.mulf %dY_val, %A_val : f32

    // GPU synchronization
    gpu.barrier

    // Store the computed result back to dW
    memref.store %update, %dW[%linear_idx] : memref<16xf32, 1>
    return
  }
}
