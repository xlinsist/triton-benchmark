module attributes {
  llvm.data_layout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1",
  llvm.target_triple = "riscv32"
} {
  func.func private @_Z13get_global_idj(i32) -> i32

  func.func @backprop(
    %dY: memref<16xf32, 1>,   // 1D 存储的 4x4 误差梯度矩阵
    %A: memref<16xf32, 1>,    // 1D 存储的 4x4 激活矩阵
    %dW: memref<16xf32, 1>    // 1D 存储的 4x4 结果矩阵
  ) {
    // 获取线程的全局 id（假定每个线程处理矩阵中的一个元素）
    %c0 = arith.constant 0 : i32
    %c4 = arith.constant 4 : i32
    %idx_i32 = func.call @_Z13get_global_idj(%c0) : (i32) -> i32

    // 将线性索引转换为二维坐标：行 = idx / 4，列 = idx % 4
    %row_i32 = arith.divsi %idx_i32, %c4 : i32
    %col_i32 = arith.remsi %idx_i32, %c4 : i32

    // 转换为 index 类型
    %row = arith.index_cast %row_i32 : i32 to index
    %col = arith.index_cast %col_i32 : i32 to index

    // 将常量 %c4 转换为 index 类型
    %c4_index = arith.index_cast %c4 : i32 to index

    // 计算二维坐标对应的一维线性下标（理论上与原 idx 相同）
    %row_mul = arith.muli %row, %c4_index : index
    %linear_idx = arith.addi %row_mul, %col : index

    // 从 dY 和 A 中读取对应元素，计算梯度更新
    %dY_val = memref.load %dY[%linear_idx] : memref<16xf32, 1>
    %A_val = memref.load %A[%linear_idx] : memref<16xf32, 1>
    %update = arith.mulf %dY_val, %A_val : f32

    // GPU 同步
    gpu.barrier

    // 将计算结果写回 dW
    memref.store %update, %dW[%linear_idx] : memref<16xf32, 1>
    return
  }
}

