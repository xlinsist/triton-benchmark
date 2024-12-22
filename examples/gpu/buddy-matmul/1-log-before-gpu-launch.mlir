#map = affine_map<(d0) -> (d0 * 128)>
#map1 = affine_map<(d0) -> (d0 * 256)>
#map2 = affine_map<(d0) -> (d0 * 64)>
#map3 = affine_map<(d0) -> (d0 * 4)>
#map4 = affine_map<(d0, d1) -> (d0 * 128 + d1 * 4)>
#map5 = affine_map<(d0)[s0] -> (d0 * 4 + s0)>
#map6 = affine_map<(d0) -> (d0 * 2)>
#map7 = affine_map<(d0) -> (d0 * 16)>
#map8 = affine_map<(d0)[s0] -> (d0 * 2 + s0)>
#map9 = affine_map<(d0, d1) -> (d0 * 256 + d1 * 16)>
#map10 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map11 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map12 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @matmul(%arg0: memref<5376x2048xf32>, %arg1: memref<2048x5376xf32>) -> memref<5376x5376xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<64x128xf32>
    %c16 = arith.constant 16 : index
    %c2048 = arith.constant 2048 : index
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5376x5376xf32>
    scf.forall (%arg2, %arg3) in (42, 21) {
      %0 = affine.apply #map(%arg2)
      %1 = affine.apply #map1(%arg3)
      %subview = memref.subview %alloc[%0, %1] [128, 256] [1, 1] : memref<5376x5376xf32> to memref<128x256xf32, strided<[5376, 1], offset: ?>>
      scf.forall (%arg4, %arg5) in (2, 2) {
        %3 = affine.apply #map2(%arg4)
        %4 = affine.apply #map(%arg5)
        %subview_2 = memref.subview %subview[%3, %4] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
        vector.transfer_write %cst, %subview_2[%c0, %c0] {in_bounds = [true, true]} : vector<64x128xf32>, memref<64x128xf32, strided<[5376, 1], offset: ?>>
        %subview_3 = memref.subview %subview[%3, %4] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
        memref.copy %subview_2, %subview_3 : memref<64x128xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
      } {mapping = [#gpu.warp<y>, #gpu.warp<x>]}
      %2 = scf.for %arg4 = %c0 to %c2048 step %c16 iter_args(%arg5 = %subview) -> (memref<128x256xf32, strided<[5376, 1], offset: ?>>) {
        %alloc_2 = memref.alloc() : memref<128x16xf32, 3>
        scf.forall (%arg6, %arg7) in (32, 4) {
          %3 = affine.apply #map3(%arg6)
          %4 = affine.apply #map3(%arg7)
          %subview_4 = memref.subview %alloc_2[%3, %4] [4, 4] [1, 1] : memref<128x16xf32, 3> to memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
          %5 = affine.apply #map4(%arg2, %arg6)
          %6 = affine.apply #map5(%arg7)[%arg4]
          %7 = vector.transfer_read %arg0[%5, %6], %cst_0 {in_bounds = [true, true]} : memref<5376x2048xf32>, vector<4x4xf32>
          vector.transfer_write %7, %subview_4[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
          %subview_5 = memref.subview %alloc_2[%3, %4] [4, 4] [1, 1] : memref<128x16xf32, 3> to memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
          memref.copy %subview_4, %subview_5 : memref<4x4xf32, strided<[16, 1], offset: ?>, 3> to memref<4x4xf32, strided<[16, 1], offset: ?>, 3>
        } {mapping = [#gpu.thread<linear_dim_1>, #gpu.thread<linear_dim_0>]}
        %alloc_3 = memref.alloc() : memref<16x256xf32, 3>
        scf.forall (%arg6, %arg7) in (8, 16) {
          %3 = affine.apply #map6(%arg6)
          %4 = affine.apply #map7(%arg7)
          %subview_4 = memref.subview %alloc_3[%3, %4] [2, 16] [1, 1] : memref<16x256xf32, 3> to memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
          %5 = affine.apply #map8(%arg6)[%arg4]
          %6 = affine.apply #map9(%arg3, %arg7)
          %7 = vector.transfer_read %arg1[%5, %6], %cst_0 {in_bounds = [true, true]} : memref<2048x5376xf32>, vector<2x16xf32>
          vector.transfer_write %7, %subview_4[%c0, %c0] {in_bounds = [true, true]} : vector<2x16xf32>, memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
          %subview_5 = memref.subview %alloc_3[%3, %4] [2, 16] [1, 1] : memref<16x256xf32, 3> to memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
          memref.copy %subview_4, %subview_5 : memref<2x16xf32, strided<[256, 1], offset: ?>, 3> to memref<2x16xf32, strided<[256, 1], offset: ?>, 3>
        } {mapping = [#gpu.thread<linear_dim_1>, #gpu.thread<linear_dim_0>]}
        scf.forall (%arg6, %arg7) in (2, 2) {
          %3 = affine.apply #map2(%arg6)
          %4 = affine.apply #map(%arg7)
          %subview_4 = memref.subview %arg5[%3, %4] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
          %5 = vector.transfer_read %alloc_2[%3, %c0], %cst_0 {in_bounds = [true, true]} : memref<128x16xf32, 3>, vector<64x16xf32>
          %6 = vector.transfer_read %alloc_3[%c0, %4], %cst_0 {in_bounds = [true, true]} : memref<16x256xf32, 3>, vector<16x128xf32>
          %7 = vector.transfer_read %arg5[%3, %4], %cst_0 {in_bounds = [true, true]} : memref<128x256xf32, strided<[5376, 1], offset: ?>>, vector<64x128xf32>
          %8 = vector.contract {indexing_maps = [#map10, #map11, #map12], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %5, %6, %7 : vector<64x16xf32>, vector<16x128xf32> into vector<64x128xf32>
          vector.transfer_write %8, %subview_4[%c0, %c0] {in_bounds = [true, true]} : vector<64x128xf32>, memref<64x128xf32, strided<[5376, 1], offset: ?>>
          %subview_5 = memref.subview %arg5[%3, %4] [64, 128] [1, 1] : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
          memref.copy %subview_4, %subview_5 : memref<64x128xf32, strided<[5376, 1], offset: ?>> to memref<64x128xf32, strided<[5376, 1], offset: ?>>
        } {mapping = [#gpu.warp<y>, #gpu.warp<x>]}
        scf.yield %arg5 : memref<128x256xf32, strided<[5376, 1], offset: ?>>
      }
      %subview_1 = memref.subview %alloc[%0, %1] [128, 256] [1, 1] : memref<5376x5376xf32> to memref<128x256xf32, strided<[5376, 1], offset: ?>>
      memref.copy %2, %subview_1 : memref<128x256xf32, strided<[5376, 1], offset: ?>> to memref<128x256xf32, strided<[5376, 1], offset: ?>>
    } {mapping = [#gpu.block<y>, #gpu.block<x>]}
    return %alloc : memref<5376x5376xf32>
  }
}

