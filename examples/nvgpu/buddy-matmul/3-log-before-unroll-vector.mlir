#map = affine_map<(d0) -> (d0 * 64)>
#map1 = affine_map<(d0) -> ((d0 floordiv 32) * 128)>
#map2 = affine_map<(d0, d1) -> (d0 * 128 + d1 * 64)>
#map3 = affine_map<(d0, d1) -> (d0 * 256 + (d1 floordiv 32) * 128)>
#map4 = affine_map<(d0, d1) -> (d0 * -128 - d1 * 64 + 5376)>
#map5 = affine_map<(d0, d1) -> (d0 * -256 - (d1 floordiv 32) * 128 + 5376)>
#map6 = affine_map<(d0, d1, d2) -> (d0 * 128 + d2 * 64 + (d1 floordiv 4) * 4)>
#map7 = affine_map<(d0, d1) -> (d0 * 256 + d1 * 16 - (d1 floordiv 16) * 256)>
#map8 = affine_map<(d0, d1, d2) -> (d0 * -128 - d2 * 64 - (d1 floordiv 4) * 4 + 5376)>
#map9 = affine_map<(d0, d1) -> (d1 * 64 + (d0 floordiv 4) * 4)>
#map10 = affine_map<(d0) -> (d0 * 4 - (d0 floordiv 4) * 16)>
#map11 = affine_map<(d0, d1) -> (d1 * -64 - (d0 floordiv 4) * 4 + 128)>
#map12 = affine_map<(d0) -> (d0 * -4 + (d0 floordiv 4) * 16 + 16)>
#map13 = affine_map<(d0, d1) -> (d0 * -256 - d1 * 16 + (d1 floordiv 16) * 256 + 5376)>
#map14 = affine_map<(d0, d1) -> (d1 * 8 + (d0 floordiv 16) * 2)>
#map15 = affine_map<(d0) -> (d0 * 16 - (d0 floordiv 16) * 256)>
#map16 = affine_map<(d0, d1) -> (d1 * -8 - (d0 floordiv 16) * 2 + 16)>
#map17 = affine_map<(d0) -> (d0 * -16 + (d0 floordiv 16) * 256 + 256)>
#map18 = affine_map<(d0) -> (d0 * -64 + 128)>
#map19 = affine_map<(d0) -> ((d0 floordiv 32) * -128 + 256)>
#map20 = affine_map<(d0)[s0] -> (d0 * 4 + s0 - (d0 floordiv 4) * 16)>
#map21 = affine_map<(d0)[s0] -> (d0 * -4 - s0 + (d0 floordiv 4) * 16 + 2048)>
#map22 = affine_map<(d0, d1)[s0] -> (d1 * 8 + s0 + (d0 floordiv 16) * 2)>
#map23 = affine_map<(d0, d1)[s0] -> (d1 * -8 - s0 - (d0 floordiv 16) * 2 + 2048)>
#map24 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map25 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map26 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @matmul(%arg0: memref<5376x2048xf32>, %arg1: memref<2048x5376xf32>) -> memref<5376x5376xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c2048 = arith.constant 2048 : index
    %c16 = arith.constant 16 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<64x128xf32>
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c2 = arith.constant 2 : index
    %c21 = arith.constant 21 : index
    %c42 = arith.constant 42 : index
    %alloc = memref.alloc() : memref<16x256xf32, 3>
    %alloc_1 = memref.alloc() : memref<128x16xf32, 3>
    %alloc_2 = memref.alloc() {alignment = 64 : i64} : memref<5376x5376xf32>
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %c21, %arg9 = %c42, %arg10 = %c1) threads(%arg5, %arg6, %arg7) in (%arg11 = %c64, %arg12 = %c2, %arg13 = %c1) {
      %0 = gpu.block_id  x
      %1 = gpu.block_id  y
      %2 = gpu.thread_id  x
      %3 = gpu.thread_id  y
      %4 = affine.apply #map(%3)
      %5 = affine.apply #map1(%2)
      %6 = affine.apply #map2(%1, %3)
      %7 = affine.apply #map3(%0, %2)
      %8 = affine.apply #map4(%1, %3)
      %9 = affine.apply #map5(%0, %2)
      %subview = memref.subview %alloc_2[%6, %7] [%8, %9] [1, 1] : memref<5376x5376xf32> to memref<?x?xf32, strided<[5376, 1], offset: ?>>
      vector.transfer_write %cst_0, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<64x128xf32>, memref<?x?xf32, strided<[5376, 1], offset: ?>>
      gpu.barrier
      %10 = affine.apply #map6(%1, %2, %3)
      %11 = affine.apply #map7(%0, %2)
      %12 = affine.apply #map8(%1, %2, %3)
      %13 = affine.apply #map9(%2, %3)
      %14 = affine.apply #map10(%2)
      %15 = affine.apply #map11(%2, %3)
      %16 = affine.apply #map12(%2)
      %subview_3 = memref.subview %alloc_1[%13, %14] [%15, %16] [1, 1] : memref<128x16xf32, 3> to memref<?x?xf32, strided<[16, 1], offset: ?>, 3>
      %17 = affine.apply #map13(%0, %2)
      %18 = affine.apply #map14(%2, %3)
      %19 = affine.apply #map15(%2)
      %20 = affine.apply #map16(%2, %3)
      %21 = affine.apply #map17(%2)
      %subview_4 = memref.subview %alloc[%18, %19] [%20, %21] [1, 1] : memref<16x256xf32, 3> to memref<?x?xf32, strided<[256, 1], offset: ?>, 3>
      %22 = affine.apply #map18(%3)
      %subview_5 = memref.subview %alloc_1[%4, 0] [%22, 16] [1, 1] : memref<128x16xf32, 3> to memref<?x16xf32, strided<[16, 1], offset: ?>, 3>
      %23 = affine.apply #map19(%2)
      %subview_6 = memref.subview %alloc[0, %5] [16, %23] [1, 1] : memref<16x256xf32, 3> to memref<16x?xf32, strided<[256, 1], offset: ?>, 3>
      scf.for %arg14 = %c0 to %c2048 step %c16 {
        %24 = affine.apply #map20(%2)[%arg14]
        %25 = affine.apply #map21(%2)[%arg14]
        %subview_7 = memref.subview %arg0[%10, %24] [%12, %25] [1, 1] : memref<5376x2048xf32> to memref<?x?xf32, strided<[2048, 1], offset: ?>>
        %26 = vector.transfer_read %subview_7[%c0, %c0], %cst {in_bounds = [true, true]} : memref<?x?xf32, strided<[2048, 1], offset: ?>>, vector<4x4xf32>
        vector.transfer_write %26, %subview_3[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<?x?xf32, strided<[16, 1], offset: ?>, 3>
        gpu.barrier
        %27 = affine.apply #map22(%2, %3)[%arg14]
        %28 = affine.apply #map23(%2, %3)[%arg14]
        %subview_8 = memref.subview %arg1[%27, %11] [%28, %17] [1, 1] : memref<2048x5376xf32> to memref<?x?xf32, strided<[5376, 1], offset: ?>>
        %29 = vector.transfer_read %subview_8[%c0, %c0], %cst {in_bounds = [true, true]} : memref<?x?xf32, strided<[5376, 1], offset: ?>>, vector<2x16xf32>
        vector.transfer_write %29, %subview_4[%c0, %c0] {in_bounds = [true, true]} : vector<2x16xf32>, memref<?x?xf32, strided<[256, 1], offset: ?>, 3>
        gpu.barrier
        %30 = vector.transfer_read %subview_5[%c0, %c0], %cst {in_bounds = [true, true]} : memref<?x16xf32, strided<[16, 1], offset: ?>, 3>, vector<64x16xf32>
        %31 = vector.transfer_read %subview_6[%c0, %c0], %cst {in_bounds = [true, true]} : memref<16x?xf32, strided<[256, 1], offset: ?>, 3>, vector<16x128xf32>
        %32 = vector.transfer_read %subview[%c0, %c0], %cst {in_bounds = [true, true]} : memref<?x?xf32, strided<[5376, 1], offset: ?>>, vector<64x128xf32>
        %33 = vector.contract {indexing_maps = [#map24, #map25, #map26], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %30, %31, %32 : vector<64x16xf32>, vector<16x128xf32> into vector<64x128xf32>
        vector.transfer_write %33, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<64x128xf32>, memref<?x?xf32, strided<[5376, 1], offset: ?>>
        gpu.barrier
      }
      gpu.terminator
    }
    memref.dealloc %alloc_1 : memref<128x16xf32, 3>
    memref.dealloc %alloc : memref<16x256xf32, 3>
    return %alloc_2 : memref<5376x5376xf32>
  }
}

