module attributes { transform.with_named_sequence } {
  transform.named_sequence @codegen(%arg0: !transform.any_op) {
    // Match the target operations and assign them to SSA values.
    %matmul = transform.structured.match ops{["linalg.matmul"]} in %arg0
      : (!transform.any_op) -> !transform.any_op
    %fill = transform.structured.match ops{["linalg.fill"]} in %arg0
      : (!transform.any_op) -> !transform.any_op

    // Perform tiling for the grid.
    // For the matrix multiplication of 5376x2048 and 2048x5376, the compilation
    // strategy sets the tile size for grid-based partitioning to 128x256.
    // This means that each [128, 2048] @ [2048, 256] matmul tile is computed within a GPU block,
    // while multiple such blocks are computed in parallel across the grid.
    // `tile_sizes` specify the dimensions of the tiled matmul result.
    // `%tiled_op` is the tiled matmul operation within the `scf.forall` loop.
    // `%forall_op` is the `scf.forall` loop that maintains tile information.
    %tiled_op, %forall_op = transform.structured.tile_using_forall %matmul
      tile_sizes [128, 256] (mapping = [#gpu.block<y>, #gpu.block<x>])
      : (!transform.any_op) -> (!transform.any_op, !transform.any_op)

    // Perform canonicalization.
    %1 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    transform.apply_patterns to %1 {
      transform.apply_patterns.linalg.tiling_canonicalization
      transform.apply_patterns.scf.for_loop_canonicalization
      transform.apply_patterns.canonicalization
    } : !transform.any_op
    transform.apply_cse to %1 : !transform.any_op
    %all_loops = transform.structured.match interface{LoopLikeInterface}
        in %arg0
        : (!transform.any_op) -> !transform.any_op
    transform.apply_licm to %all_loops : !transform.any_op
    transform.apply_patterns to %1 {
    transform.apply_patterns.linalg.tiling_canonicalization
    } : !transform.any_op

    // Fuse the fill operation into the scf.all op.
    %fused_op, %new_containing_op = transform.structured.fuse_into_containing_op %fill into %forall_op : (!transform.any_op, !transform.any_op) -> (!transform.any_op, !transform.any_op)

    // Further tile the tiled matmul 
    // Tile the third dimension in matmul.
    // [128, 2048] @ [2048, 256] matmul is further tiled into [128, 16] @ [16, 256] matmul.
    %tiled_linalg_op, %loops = transform.structured.tile_using_for %tiled_op [0, 0, 16] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)

    // Create pad op and prepare for mapping to GPU.
    // Nothing has changed in the operation.
    %padded, %pad, %copy = transform.structured.pad %tiled_linalg_op {copy_back_op = "none", pack_paddings = [1, 1, 1], pad_to_multiple_of = [1, 1, 1], padding_dimensions = [0, 1, 2], padding_values = [0.000000e+00 : f32, 0.000000e+00 : f32, 0.000000e+00 : f32]} : (!transform.any_op) -> (!transform.any_op, !transform.any_op, !transform.any_op)

    // Rewrite tensor.pad into linalg.copy.
    %3 = transform.get_producer_of_operand %padded[0] : (!transform.any_op) -> !transform.any_op
    %4 = transform.get_producer_of_operand %padded[1] : (!transform.any_op) -> !transform.any_op
    %5 = transform.get_producer_of_operand %padded[2] : (!transform.any_op) -> !transform.any_op
    %6 = transform.structured.rewrite_in_destination_passing_style %3 : (!transform.any_op) -> !transform.any_op
    %7 = transform.structured.rewrite_in_destination_passing_style %4 : (!transform.any_op) -> !transform.any_op
    %8 = transform.structured.rewrite_in_destination_passing_style %5 : (!transform.any_op) -> !transform.any_op

    // Tile the linalg.copy op and map it to GPU thread level,
    // such that the tiled matrix are copied to GPU shared memory.
    // num_threads is different from tile_sizes used above,
    // as it specifies the number of tile instead of the size of the tile.
    // The first transform tile the [128, 16] into [4, 4],
    // and the second transform tile the [16, 256] into [2, 16].
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %6 num_threads [32, 4](mapping = [#gpu.thread<linear_dim_1>, #gpu.thread<linear_dim_0>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %tiled_op_2, %forall_op_3 = transform.structured.tile_using_forall %7 num_threads [8, 16](mapping = [#gpu.thread<linear_dim_1>, #gpu.thread<linear_dim_0>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)

    // Tile the linalg.matmul op and map it to GPU warp level.
    %tiled_op_4, %forall_op_5 = transform.structured.tile_using_forall %padded num_threads [2, 2](mapping = [#gpu.warp<y>, #gpu.warp<x>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    // Tile the linalg.fill op and map it to GPU warp level.
    %tiled_op_6, %forall_op_7 = transform.structured.tile_using_forall %fused_op num_threads [2, 2](mapping = [#gpu.warp<y>, #gpu.warp<x>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)

    // Perform canonicalization.
    %9 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    transform.apply_patterns to %9 {
      transform.apply_patterns.linalg.tiling_canonicalization
      transform.apply_patterns.scf.for_loop_canonicalization
      transform.apply_patterns.canonicalization
    } : !transform.any_op
    transform.apply_cse to %9 : !transform.any_op
    %all_loops_2 = transform.structured.match interface{LoopLikeInterface}
        in %9
        : (!transform.any_op) -> !transform.any_op
    transform.apply_licm to %all_loops_2 : !transform.any_op
    transform.apply_patterns to %9 {
      transform.apply_patterns.linalg.tiling_canonicalization
      transform.apply_patterns.vector.lower_masked_transfers
    } : !transform.any_op

    // Perform vectorization.
    // Vectorize the linalg.copy, linalg.fill, and linalg.matmul operations.
    %10 = transform.structured.vectorize_children_and_apply_patterns %9 : (!transform.any_op) -> !transform.any_op

    // Perform canonicalization.
    transform.apply_patterns to %10 {
      transform.apply_patterns.linalg.tiling_canonicalization
      transform.apply_patterns.scf.for_loop_canonicalization
      transform.apply_patterns.canonicalization
    } : !transform.any_op
    transform.apply_cse to %10 : !transform.any_op
    %all_loops_3 = transform.structured.match interface{LoopLikeInterface}
        in %10
        : (!transform.any_op) -> !transform.any_op
    transform.apply_licm to %all_loops_3 : !transform.any_op
    transform.apply_patterns to %10 {
      transform.apply_patterns.linalg.tiling_canonicalization
      transform.apply_patterns.vector.lower_masked_transfers
    } : !transform.any_op

    // Match bufferization.alloc_tensors inside the forall op
    %scf_forall = transform.structured.match ops{["scf.forall"]} attributes{mapping = [#gpu.block<y>, #gpu.block<x>]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %alloc_tensor_ops = transform.structured.match ops{["bufferization.alloc_tensor"]} in %scf_forall : (!transform.any_op) -> !transform.any_op

    // Bufferize the alloc_tensor ops to memref.alloc ops.
    // The memory_space attribute for GPU Dialect 0 means global memory, 3 means workgroup memory address, 5 means private memory address.
    // According to https://discourse.llvm.org/t/rfc-memref-memory-shape-as-attribute/2229
    %buffer, %new_ops = transform.structured.bufferize_to_allocation %alloc_tensor_ops {memory_space = 3 } : !transform.any_op

    // Eliminate empty tensors and erase unnecessary inputs.
    transform.structured.eliminate_empty_tensors %arg0 : !transform.any_op
    %func_eras = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %func_eras {
        transform.apply_patterns.linalg.erase_unnecessary_inputs
      } : !transform.any_op

    // Bufferize the remaining operations in one time.
    %11 = transform.bufferization.one_shot_bufferize %arg0 { bufferize_function_boundaries = true, function_boundary_type_conversion = 1 : i32} : (!transform.any_op) -> !transform.any_op

    // Erase dead alloc and stores.
    %12 = transform.structured.match ops{["func.func"]} in %11 : (!transform.any_op) -> !transform.any_op
    transform.memref.erase_dead_alloc_and_stores %12 : (!transform.any_op) -> ()

    // Generate GPU launch.
    %13 = transform.structured.match ops{["func.func"]} in %11 : (!transform.any_op) -> !transform.any_op
    %gpu_launch = transform.gpu.map_forall_to_blocks %13 { generate_gpu_launch } : (!transform.any_op) -> !transform.any_op

    // Rewrite bufferized scf.forall ops to distributed gpu.thread_id attribute.
    %mapped = transform.gpu.map_nested_forall_to_threads %gpu_launch block_dims = [64, 2, 1] warp_size = 32 : (!transform.any_op) -> !transform.any_op
    transform.yield
  }
} // module
