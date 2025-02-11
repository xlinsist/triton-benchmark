#map = affine_map<(d0) -> (d0 * 128)>
#map1 = affine_map<(d0) -> (d0 * 256)>
#map2 = affine_map<(d0) -> (d0 floordiv 32)>
#map3 = affine_map<(d0) -> (d0 * 64)>
#map4 = affine_map<(d0, d1, d2) -> (d0 + d1 * 64 + d2 * 128)>
#map5 = affine_map<(d0) -> (d0 mod 4)>
#map6 = affine_map<(d0, d1, d2) -> (d1 * 16 + d2 * 32 + d0 floordiv 4)>
#map7 = affine_map<(d0) -> (d0 * 4)>
#map8 = affine_map<(d0, d1) -> (d0 * 128 + d1 * 4)>
#map9 = affine_map<(d0)[s0] -> (d0 * 4 + s0)>
#map10 = affine_map<(d0) -> (d0 mod 16)>
#map11 = affine_map<(d0, d1, d2) -> (d1 * 4 + d2 * 8 + d0 floordiv 16)>
#map12 = affine_map<(d0) -> (d0 * 2)>
#map13 = affine_map<(d0) -> (d0 * 16)>
#map14 = affine_map<(d0)[s0] -> (d0 * 2 + s0)>
#map15 = affine_map<(d0, d1) -> (d0 * 256 + d1 * 16)>
#map16 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map17 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map18 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @matmul(%arg0: memref<5376x2048xf32>, %arg1: memref<2048x5376xf32>) -> memref<5376x5376xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<64x128xf32>
    %c16 = arith.constant 16 : index
    %c2048 = arith.constant 2048 : index
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5376x5376xf32>
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c2 = arith.constant 2 : index
    %c1_1 = arith.constant 1 : index
    %c21 = arith.constant 21 : index
    %c42 = arith.constant 42 : index
    %c1_2 = arith.constant 1 : index
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %c21, %arg9 = %c42, %arg10 = %c1_2) threads(%arg5, %arg6, %arg7) in (%arg11 = %c64, %arg12 = %c2, %arg13 = %c1_1) {
      %c0_3 = arith.constant 0 : index
      %c0_4 = arith.constant 0 : index
      %0 = gpu.block_id  x
      %1 = gpu.block_id  y
      %2 = gpu.block_id  z
      %3 = affine.apply #map(%1)
      %4 = affine.apply #map1(%0)
      %subview = memref.subview %alloc[%3, %4] [128, 256] [1, 1] : memref<5376x5376xf32> to memref<128x256xf32, strided<[5376, 1], offset: ?>>
      %5 = gpu.thread_id  x
      %6 = gpu.thread_id  y
      %7 = gpu.thread_id  z
      %8 = affine.apply #map2(%5)
      %9 = affine.apply #map3(%6)
      %10 = affine.apply #map(%8)
      %subview_5 = memref.subview %subview[%9, %10] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
      vector.transfer_write %cst, %subview_5[%c0, %c0] {in_bounds = [true, true]} : vector<64x128xf32>, memref<64x128xf32, strided<[5376, 1], offset: ?>>
      %subview_6 = memref.subview %subview[%9, %10] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
      memref.copy %subview_5, %subview_6 : memref<64x128xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
      gpu.barrier
      %11 = scf.for %arg14 = %c0 to %c2048 step %c16 iter_args(%arg15 = %subview) -> (memref<128x256xf32, strided<[5376, 1], offset: ?>>) {
        %alloc_8 = memref.alloc() : memref<128x16xf32, 3>
        %12 = gpu.thread_id  x
        %13 = gpu.thread_id  y
        %14 = gpu.thread_id  z
        %15 = affine.apply #map4(%12, %13, %c0_3)
        %16 = affine.apply #map4(%12, %13, %c0_3)
        %17 = affine.apply #map5(%12)
        %18 = affine.apply #map6(%12, %13, %c0_3)
        %19 = affine.apply #map7(%18)
        %20 = affine.apply #map7(%17)
        %subview_9 = memref.subview %alloc_8[%19, %20] [4, 4] [1, 1] : memref<128x16xf32, 3> to memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
        %21 = affine.apply #map8(%1, %18)
        %22 = affine.apply #map9(%17)[%arg14]
        %23 = vector.transfer_read %arg0[%21, %22], %cst_0 {in_bounds = [true, true]} : memref<5376x2048xf32>, vector<4x4xf32>
        vector.transfer_write %23, %subview_9[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
        %subview_10 = memref.subview %alloc_8[%19, %20] [4, 4] [1, 1] : memref<128x16xf32, 3> to memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
        memref.copy %subview_9, %subview_10 : memref<4x4xf32, strided<[16, 1], offset: ?>, 3> to memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
        gpu.barrier
        %alloc_11 = memref.alloc() : memref<16x256xf32, 3>
        %24 = gpu.thread_id  x
        %25 = gpu.thread_id  y
        %26 = gpu.thread_id  z
        %27 = affine.apply #map4(%24, %25, %c0_3)
        %28 = affine.apply #map4(%24, %25, %c0_3)
        %29 = affine.apply #map10(%24)
        %30 = affine.apply #map11(%24, %25, %c0_3)
        %31 = affine.apply #map12(%30)
        %32 = affine.apply #map13(%29)
        %subview_12 = memref.subview %alloc_11[%31, %32] [2, 16] [1, 1] : memref<16x256xf32, 3> to memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
        %33 = affine.apply #map14(%30)[%arg14]
        %34 = affine.apply #map15(%0, %29)
        %35 = vector.transfer_read %arg1[%33, %34], %cst_0 {in_bounds = [true, true]} : memref<2048x5376xf32>, vector<2x16xf32>
        vector.transfer_write %35, %subview_12[%c0, %c0] {in_bounds = [true, true]} : vector<2x16xf32>, memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
        %subview_13 = memref.subview %alloc_11[%31, %32] [2, 16] [1, 1] : memref<16x256xf32, 3> to memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
        memref.copy %subview_12, %subview_13 : memref<2x16xf32, strided<[256, 1], offset: ?>, 3> to memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
        gpu.barrier
        %36 = gpu.thread_id  x
        %37 = gpu.thread_id  y
        %38 = gpu.thread_id  z
        %39 = affine.apply #map2(%36)
        %40 = affine.apply #map3(%37)
        %41 = affine.apply #map(%39)
        %subview_14 = memref.subview %arg15[%40, %41] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
        %42 = vector.transfer_read %alloc_8[%40, %c0], %cst_0 {in_bounds = [true, true]} : memref<128x16xf32, 3>, vector<64x16xf32>
        %43 = vector.transfer_read %alloc_11[%c0, %41], %cst_0 {in_bounds = [true, true]} : memref<16x256xf32, 3>, vector<16x128xf32>
        %44 = vector.transfer_read %arg15[%40, %41], %cst_0 {in_bounds = [true, true]} : memref<128x256xf32, strided<[5376, 1], offset: ?>>, vector<64x128xf32>
        %45 = vector.contract {indexing_maps = [#map16, #map17, #map18], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %42, %43, %44 : vector<64x16xf32>, vector<16x128xf32> into vector<64x128xf32>
        vector.transfer_write %45, %subview_14[%c0, %c0] {in_bounds = [true, true]} : vector<64x128xf32>, memref<64x128xf32, strided<[5376, 1], offset: ?>>
        %subview_15 = memref.subview %arg15[%40, %41] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
        memref.copy %subview_14, %subview_15 : memref<64x128xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
        gpu.barrier
        scf.yield %arg15 : memref<128x256xf32, strided<[5376, 1], offset: ?>>
      }
      %subview_7 = memref.subview %alloc[%3, %4] [128, 256] [1, 1] : memref<5376x5376xf32> to memref<128x256xf32, strided<[5376, 1], offset: ?>>
      memref.copy %11, %subview_7 : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<128x256xf32, strided<[5376, 1], offset: ?>>
      gpu.terminator
    }
    return %alloc : memref<5376x5376xf32>
  }
}

