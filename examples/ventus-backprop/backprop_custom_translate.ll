; generated from `backprop_official_import_llvm.mlir` by `translate`. 
; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1"
target triple = "riscv32"

; Function Attrs: nounwind
define ventus_kernel void @bpnn_layerforward_ocl(ptr addrspace(1) %0, ptr addrspace(1) %1, ptr addrspace(1) %2, ptr addrspace(1) %3, ptr addrspace(3) %4, ptr addrspace(3) %5, i32 %6, i32 %7) #0 {
  %9 = call i32 @_Z12get_group_idj(i32 1)
  %10 = call i32 @_Z12get_local_idj(i32 0)
  %11 = call i32 @_Z12get_local_idj(i32 1)
  %12 = add i32 %7, 1
  %13 = shl i32 %9, 4
  %14 = add i32 %11, %13
  %15 = mul i32 %14, %12
  %16 = add i32 %7, 2
  %17 = add i32 %16, %10
  %18 = add i32 %17, %15
  %19 = icmp eq i32 %10, 0
  br i1 %19, label %20, label %26

20:                                               ; preds = %8
  %21 = getelementptr float, ptr addrspace(3) %4, i32 %11
  %22 = or i32 %13, 1
  %23 = add i32 %22, %11
  %24 = getelementptr float, ptr addrspace(1) %0, i32 %23
  %25 = load float, ptr addrspace(1) %24, align 4
  store float %25, ptr addrspace(3) %21, align 4
  br label %26

26:                                               ; preds = %20, %8
  call void @llvm.riscv.ventus.barrier(i32 1)
  %27 = getelementptr float, ptr addrspace(1) %2, i32 %18
  %28 = load float, ptr addrspace(1) %27, align 4
  %29 = shl i32 %11, 4
  %30 = add i32 %29, %10
  %31 = getelementptr float, ptr addrspace(3) %5, i32 %30
  store float %28, ptr addrspace(3) %31, align 4
  call void @llvm.riscv.ventus.barrier(i32 1)
  %32 = load float, ptr addrspace(3) %31, align 4
  %33 = getelementptr float, ptr addrspace(3) %4, i32 %11
  %34 = load float, ptr addrspace(3) %33, align 4
  %35 = fmul float %32, %34
  store float %35, ptr addrspace(3) %31, align 4
  call void @llvm.riscv.ventus.barrier(i32 1)
  %36 = load float, ptr addrspace(3) %31, align 4
  %37 = fadd float %36, %36
  store float %37, ptr addrspace(3) %31, align 4
  call void @llvm.riscv.ventus.barrier(i32 1)
  %38 = and i32 %11, 1
  %39 = icmp eq i32 %38, 0
  br i1 %39, label %40, label %48

40:                                               ; preds = %26
  %41 = load float, ptr addrspace(3) %31, align 4
  %42 = shl i32 %11, 4
  %43 = add i32 %42, 16
  %44 = add i32 %43, %10
  %45 = getelementptr float, ptr addrspace(3) %5, i32 %44
  %46 = load float, ptr addrspace(3) %45, align 4
  %47 = fadd float %41, %46
  store float %47, ptr addrspace(3) %31, align 4
  br label %48

48:                                               ; preds = %40, %26
  call void @llvm.riscv.ventus.barrier(i32 1)
  %49 = and i32 %11, 3
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %51, label %59

51:                                               ; preds = %48
  %52 = load float, ptr addrspace(3) %31, align 4
  %53 = shl i32 %11, 4
  %54 = add i32 %53, 32
  %55 = add i32 %54, %10
  %56 = getelementptr float, ptr addrspace(3) %5, i32 %55
  %57 = load float, ptr addrspace(3) %56, align 4
  %58 = fadd float %52, %57
  store float %58, ptr addrspace(3) %31, align 4
  br label %59

59:                                               ; preds = %51, %48
  call void @llvm.riscv.ventus.barrier(i32 1)
  %60 = and i32 %11, 7
  %61 = icmp eq i32 %60, 0
  br i1 %61, label %62, label %70

62:                                               ; preds = %59
  %63 = load float, ptr addrspace(3) %31, align 4
  %64 = shl i32 %11, 4
  %65 = add i32 %64, 64
  %66 = add i32 %65, %10
  %67 = getelementptr float, ptr addrspace(3) %5, i32 %66
  %68 = load float, ptr addrspace(3) %67, align 4
  %69 = fadd float %63, %68
  store float %69, ptr addrspace(3) %31, align 4
  br label %70

70:                                               ; preds = %62, %59
  call void @llvm.riscv.ventus.barrier(i32 1)
  %71 = and i32 %11, 15
  %72 = icmp eq i32 %71, 0
  br i1 %72, label %73, label %81

73:                                               ; preds = %70
  %74 = load float, ptr addrspace(3) %31, align 4
  %75 = shl i32 %11, 4
  %76 = add i32 %75, 128
  %77 = add i32 %76, %10
  %78 = getelementptr float, ptr addrspace(3) %5, i32 %77
  %79 = load float, ptr addrspace(3) %78, align 4
  %80 = fadd float %74, %79
  store float %80, ptr addrspace(3) %31, align 4
  br label %81

81:                                               ; preds = %73, %70
  call void @llvm.riscv.ventus.barrier(i32 1)
  %82 = load float, ptr addrspace(3) %31, align 4
  store float %82, ptr addrspace(1) %27, align 4
  call void @llvm.riscv.ventus.barrier(i32 1)
  br i1 %19, label %83, label %89

83:                                               ; preds = %81
  %84 = mul i32 %9, %7
  %85 = add i32 %11, %84
  %86 = getelementptr float, ptr addrspace(1) %3, i32 %85
  %87 = getelementptr float, ptr addrspace(3) %5, i32 %11
  %88 = load float, ptr addrspace(3) %87, align 4
  store float %88, ptr addrspace(1) %86, align 4
  br label %89

89:                                               ; preds = %83, %81
  ret void
}

; Function Attrs: memory(none)
declare i32 @_Z12get_group_idj(i32) #1

; Function Attrs: memory(none)
declare i32 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
declare void @llvm.riscv.ventus.barrier(i32 immarg) #0

; Function Attrs: nounwind
define ventus_kernel void @bpnn_adjust_weights_ocl(ptr addrspace(1) %0, i32 %1, ptr addrspace(1) %2, i32 %3, ptr addrspace(1) %4, ptr addrspace(1) %5) #0 {
  %7 = call i32 @_Z12get_group_idj(i32 1)
  %8 = call i32 @_Z12get_local_idj(i32 0)
  %9 = call i32 @_Z12get_local_idj(i32 1)
  %10 = add i32 %1, 1
  %11 = shl i32 %7, 4
  %12 = add i32 %9, %11
  %13 = mul i32 %12, %10
  %14 = add i32 %8, 1
  %15 = add i32 %14, %10
  %16 = add i32 %15, %13
  %17 = or i32 %11, 1
  %18 = add i32 %17, %9
  %19 = getelementptr float, ptr addrspace(1) %0, i32 %14
  %20 = load float, ptr addrspace(1) %19, align 4
  %21 = fmul float %20, 0x3FD3333340000000
  %22 = getelementptr float, ptr addrspace(1) %2, i32 %18
  %23 = load float, ptr addrspace(1) %22, align 4
  %24 = getelementptr float, ptr addrspace(1) %5, i32 %16
  %25 = load float, ptr addrspace(1) %24, align 4
  %26 = fmul float %25, 0x3FD3333340000000
  %27 = call float @llvm.fmuladd.f32(float %21, float %23, float %26)
  %28 = getelementptr float, ptr addrspace(1) %4, i32 %16
  %29 = load float, ptr addrspace(1) %28, align 4
  %30 = fadd float %29, %27
  store float %30, ptr addrspace(1) %28, align 4
  %31 = load float, ptr addrspace(1) %19, align 4
  %32 = fmul float %31, 0x3FD3333340000000
  %33 = load float, ptr addrspace(1) %22, align 4
  %34 = load float, ptr addrspace(1) %24, align 4
  %35 = fmul float %34, 0x3FD3333340000000
  %36 = call float @llvm.fmuladd.f32(float %32, float %33, float %35)
  store float %36, ptr addrspace(1) %24, align 4
  call void @llvm.riscv.ventus.barrier(i32 1)
  %37 = icmp eq i32 %9, 0
  %38 = icmp eq i32 %7, 0
  %39 = select i1 %37, i1 %38, i1 false
  br i1 %39, label %40, label %53

40:                                               ; preds = %6
  %41 = load float, ptr addrspace(1) %19, align 4
  %42 = getelementptr float, ptr addrspace(1) %5, i32 %14
  %43 = load float, ptr addrspace(1) %42, align 4
  %44 = fmul float %43, 0x3FD3333340000000
  %45 = call float @llvm.fmuladd.f32(float %41, float 0x3FD3333340000000, float %44)
  %46 = getelementptr float, ptr addrspace(1) %4, i32 %14
  %47 = load float, ptr addrspace(1) %46, align 4
  %48 = fadd float %47, %45
  store float %48, ptr addrspace(1) %46, align 4
  %49 = load float, ptr addrspace(1) %19, align 4
  %50 = load float, ptr addrspace(1) %42, align 4
  %51 = fmul float %50, 0x3FD3333340000000
  %52 = call float @llvm.fmuladd.f32(float %49, float 0x3FD3333340000000, float %51)
  store float %52, ptr addrspace(1) %42, align 4
  br label %53

53:                                               ; preds = %40, %6
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #2

attributes #0 = { nounwind }
attributes #1 = { memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.ident = !{!0}

!0 = !{!"clang version 16.0.0 (https://github.com/THU-DSP-LAB/llvm-project.git 0f31d6ca085de0b69ab06e00b0add1cbe1b2b7ed)"}

