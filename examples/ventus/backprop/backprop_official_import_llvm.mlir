module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>} {
  llvm.func ventus_kernelcc @bpnn_layerforward_ocl(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>, %arg3: !llvm.ptr<1>, %arg4: !llvm.ptr<3>, %arg5: !llvm.ptr<3>, %arg6: i32, %arg7: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(16 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(32 : i32) : i32
    %7 = llvm.mlir.constant(7 : i32) : i32
    %8 = llvm.mlir.constant(64 : i32) : i32
    %9 = llvm.mlir.constant(15 : i32) : i32
    %10 = llvm.mlir.constant(128 : i32) : i32
    %11 = llvm.call @_Z12get_group_idj(%0) : (i32) -> i32
    %12 = llvm.call @_Z12get_local_idj(%1) : (i32) -> i32
    %13 = llvm.call @_Z12get_local_idj(%0) : (i32) -> i32
    %14 = llvm.add %arg7, %0  : i32
    %15 = llvm.shl %11, %2  : i32
    %16 = llvm.add %13, %15  : i32
    %17 = llvm.mul %16, %14  : i32
    %18 = llvm.add %arg7, %3  : i32
    %19 = llvm.add %18, %12  : i32
    %20 = llvm.add %19, %17  : i32
    %21 = llvm.icmp "eq" %12, %1 : i32
    llvm.cond_br %21, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %22 = llvm.getelementptr %arg4[%13] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %23 = llvm.or %15, %0  : i32
    %24 = llvm.add %23, %13  : i32
    %25 = llvm.getelementptr %arg0[%24] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %26 = llvm.load %25 : !llvm.ptr<1> -> f32
    llvm.store %26, %22 : f32, !llvm.ptr<3>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %27 = llvm.getelementptr %arg2[%20] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %28 = llvm.load %27 : !llvm.ptr<1> -> f32
    %29 = llvm.shl %13, %2  : i32
    %30 = llvm.add %29, %12  : i32
    %31 = llvm.getelementptr %arg5[%30] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    llvm.store %28, %31 : f32, !llvm.ptr<3>
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %32 = llvm.load %31 : !llvm.ptr<3> -> f32
    %33 = llvm.getelementptr %arg4[%13] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %34 = llvm.load %33 : !llvm.ptr<3> -> f32
    %35 = llvm.fmul %32, %34  : f32
    llvm.store %35, %31 : f32, !llvm.ptr<3>
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %36 = llvm.load %31 : !llvm.ptr<3> -> f32
    %37 = llvm.fadd %36, %36  : f32
    llvm.store %37, %31 : f32, !llvm.ptr<3>
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %38 = llvm.and %13, %0  : i32
    %39 = llvm.icmp "eq" %38, %1 : i32
    llvm.cond_br %39, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %40 = llvm.load %31 : !llvm.ptr<3> -> f32
    %41 = llvm.shl %13, %2  : i32
    %42 = llvm.add %41, %4  : i32
    %43 = llvm.add %42, %12  : i32
    %44 = llvm.getelementptr %arg5[%43] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %45 = llvm.load %44 : !llvm.ptr<3> -> f32
    %46 = llvm.fadd %40, %45  : f32
    llvm.store %46, %31 : f32, !llvm.ptr<3>
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %47 = llvm.and %13, %5  : i32
    %48 = llvm.icmp "eq" %47, %1 : i32
    llvm.cond_br %48, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %49 = llvm.load %31 : !llvm.ptr<3> -> f32
    %50 = llvm.shl %13, %2  : i32
    %51 = llvm.add %50, %6  : i32
    %52 = llvm.add %51, %12  : i32
    %53 = llvm.getelementptr %arg5[%52] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %54 = llvm.load %53 : !llvm.ptr<3> -> f32
    %55 = llvm.fadd %49, %54  : f32
    llvm.store %55, %31 : f32, !llvm.ptr<3>
    llvm.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %56 = llvm.and %13, %7  : i32
    %57 = llvm.icmp "eq" %56, %1 : i32
    llvm.cond_br %57, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %58 = llvm.load %31 : !llvm.ptr<3> -> f32
    %59 = llvm.shl %13, %2  : i32
    %60 = llvm.add %59, %8  : i32
    %61 = llvm.add %60, %12  : i32
    %62 = llvm.getelementptr %arg5[%61] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %63 = llvm.load %62 : !llvm.ptr<3> -> f32
    %64 = llvm.fadd %58, %63  : f32
    llvm.store %64, %31 : f32, !llvm.ptr<3>
    llvm.br ^bb8
  ^bb8:  // 2 preds: ^bb6, ^bb7
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %65 = llvm.and %13, %9  : i32
    %66 = llvm.icmp "eq" %65, %1 : i32
    llvm.cond_br %66, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    %67 = llvm.load %31 : !llvm.ptr<3> -> f32
    %68 = llvm.shl %13, %2  : i32
    %69 = llvm.add %68, %10  : i32
    %70 = llvm.add %69, %12  : i32
    %71 = llvm.getelementptr %arg5[%70] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %72 = llvm.load %71 : !llvm.ptr<3> -> f32
    %73 = llvm.fadd %67, %72  : f32
    llvm.store %73, %31 : f32, !llvm.ptr<3>
    llvm.br ^bb10
  ^bb10:  // 2 preds: ^bb8, ^bb9
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %74 = llvm.load %31 : !llvm.ptr<3> -> f32
    llvm.store %74, %27 : f32, !llvm.ptr<1>
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    llvm.cond_br %21, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %75 = llvm.mul %11, %arg7  : i32
    %76 = llvm.add %13, %75  : i32
    %77 = llvm.getelementptr %arg3[%76] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %78 = llvm.getelementptr %arg5[%13] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %79 = llvm.load %78 : !llvm.ptr<3> -> f32
    llvm.store %79, %77 : f32, !llvm.ptr<1>
    llvm.br ^bb12
  ^bb12:  // 2 preds: ^bb10, ^bb11
    llvm.return
  }
  llvm.func @_Z12get_group_idj(i32) -> i32 attributes {llvm.readnone}
  llvm.func @_Z12get_local_idj(i32) -> i32 attributes {llvm.readnone}
  llvm.func @llvm.riscv.ventus.barrier(i32)
  llvm.func ventus_kernelcc @bpnn_adjust_weights_ocl(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: !llvm.ptr<1>, %arg3: i32, %arg4: !llvm.ptr<1>, %arg5: !llvm.ptr<1>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(3.000000e-01 : f32) : f32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.call @_Z12get_group_idj(%0) : (i32) -> i32
    %6 = llvm.call @_Z12get_local_idj(%1) : (i32) -> i32
    %7 = llvm.call @_Z12get_local_idj(%0) : (i32) -> i32
    %8 = llvm.add %arg1, %0  : i32
    %9 = llvm.shl %5, %2  : i32
    %10 = llvm.add %7, %9  : i32
    %11 = llvm.mul %10, %8  : i32
    %12 = llvm.add %6, %0  : i32
    %13 = llvm.add %12, %8  : i32
    %14 = llvm.add %13, %11  : i32
    %15 = llvm.or %9, %0  : i32
    %16 = llvm.add %15, %7  : i32
    %17 = llvm.getelementptr %arg0[%12] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %18 = llvm.load %17 : !llvm.ptr<1> -> f32
    %19 = llvm.fmul %18, %3  : f32
    %20 = llvm.getelementptr %arg2[%16] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %21 = llvm.load %20 : !llvm.ptr<1> -> f32
    %22 = llvm.getelementptr %arg5[%14] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %23 = llvm.load %22 : !llvm.ptr<1> -> f32
    %24 = llvm.fmul %23, %3  : f32
    %25 = llvm.intr.fmuladd(%19, %21, %24)  : (f32, f32, f32) -> f32
    %26 = llvm.getelementptr %arg4[%14] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %27 = llvm.load %26 : !llvm.ptr<1> -> f32
    %28 = llvm.fadd %27, %25  : f32
    llvm.store %28, %26 : f32, !llvm.ptr<1>
    %29 = llvm.load %17 : !llvm.ptr<1> -> f32
    %30 = llvm.fmul %29, %3  : f32
    %31 = llvm.load %20 : !llvm.ptr<1> -> f32
    %32 = llvm.load %22 : !llvm.ptr<1> -> f32
    %33 = llvm.fmul %32, %3  : f32
    %34 = llvm.intr.fmuladd(%30, %31, %33)  : (f32, f32, f32) -> f32
    llvm.store %34, %22 : f32, !llvm.ptr<1>
    llvm.call @llvm.riscv.ventus.barrier(%0) : (i32) -> ()
    %35 = llvm.icmp "eq" %7, %1 : i32
    %36 = llvm.icmp "eq" %5, %1 : i32
    %37 = llvm.select %35, %36, %4 : i1, i1
    llvm.cond_br %37, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %38 = llvm.load %17 : !llvm.ptr<1> -> f32
    %39 = llvm.getelementptr %arg5[%12] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %40 = llvm.load %39 : !llvm.ptr<1> -> f32
    %41 = llvm.fmul %40, %3  : f32
    %42 = llvm.intr.fmuladd(%38, %3, %41)  : (f32, f32, f32) -> f32
    %43 = llvm.getelementptr %arg4[%12] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %44 = llvm.load %43 : !llvm.ptr<1> -> f32
    %45 = llvm.fadd %44, %42  : f32
    llvm.store %45, %43 : f32, !llvm.ptr<1>
    %46 = llvm.load %17 : !llvm.ptr<1> -> f32
    %47 = llvm.load %39 : !llvm.ptr<1> -> f32
    %48 = llvm.fmul %47, %3  : f32
    %49 = llvm.intr.fmuladd(%46, %3, %48)  : (f32, f32, f32) -> f32
    llvm.store %49, %39 : f32, !llvm.ptr<1>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
}
