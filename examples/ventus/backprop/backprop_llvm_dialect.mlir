module attributes {llvm.data_layout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1", llvm.target_triple = "riscv32"} {
  llvm.func @_Z13get_global_idj(i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @backprop(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg2, %0[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.mlir.constant(16 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.undef : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg1, %9[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg1, %10[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.mlir.constant(16 : index) : i64
    %15 = llvm.insertvalue %14, %13[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.insertvalue %16, %15[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.mlir.undef : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %19 = llvm.insertvalue %arg0, %18[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.insertvalue %arg0, %19[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.mlir.constant(0 : index) : i64
    %22 = llvm.insertvalue %21, %20[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.mlir.constant(16 : index) : i64
    %24 = llvm.insertvalue %23, %22[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.insertvalue %25, %24[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.mlir.constant(0 : i32) : i32
    %28 = llvm.mlir.constant(4 : i32) : i32
    %29 = llvm.call @_Z13get_global_idj(%27) : (i32) -> i32
    %30 = llvm.sdiv %29, %28 : i32
    %31 = llvm.srem %29, %28 : i32
    %32 = llvm.sext %30 : i32 to i64
    %33 = llvm.sext %31 : i32 to i64
    %34 = llvm.mlir.constant(4 : index) : i64
    %35 = llvm.mul %32, %34 : i64
    %36 = llvm.add %35, %33 : i64
    %37 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.getelementptr %37[%36] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
    %39 = llvm.load %38 : !llvm.ptr<1> -> f32
    %40 = llvm.extractvalue %17[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %41 = llvm.getelementptr %40[%36] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
    %42 = llvm.load %41 : !llvm.ptr<1> -> f32
    %43 = llvm.fmul %39, %42 : f32
    gpu.barrier
    %44 = llvm.extractvalue %8[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.getelementptr %44[%36] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
    llvm.store %43, %45 : f32, !llvm.ptr<1>
    llvm.return
  }
}

