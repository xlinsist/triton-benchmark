; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1"
target triple = "riscv32"

declare i32 @_Z13get_global_idj(i32)

define ventus_kernel void @backprop(ptr addrspace(1) %0, ptr addrspace(1) %1, ptr addrspace(1) %2) {
  %4 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } undef, ptr addrspace(1) %2, 0
  %5 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %4, ptr addrspace(1) %2, 1
  %6 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %5, i64 0, 2
  %7 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %6, i64 16, 3, 0
  %8 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %7, i64 1, 4, 0
  %9 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } undef, ptr addrspace(1) %1, 0
  %10 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %9, ptr addrspace(1) %1, 1
  %11 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %10, i64 0, 2
  %12 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %11, i64 16, 3, 0
  %13 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %12, i64 1, 4, 0
  %14 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } undef, ptr addrspace(1) %0, 0
  %15 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %14, ptr addrspace(1) %0, 1
  %16 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %15, i64 0, 2
  %17 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %16, i64 16, 3, 0
  %18 = insertvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %17, i64 1, 4, 0
  %19 = call i32 @_Z13get_global_idj(i32 0)
  %20 = sdiv i32 %19, 4
  %21 = srem i32 %19, 4
  %22 = sext i32 %20 to i64
  %23 = sext i32 %21 to i64
  %24 = mul i64 %22, 4
  %25 = add i64 %24, %23
  %26 = extractvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %18, 1
  %27 = getelementptr float, ptr addrspace(1) %26, i64 %25
  %28 = load float, ptr addrspace(1) %27, align 4
  %29 = extractvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %13, 1
  %30 = getelementptr float, ptr addrspace(1) %29, i64 %25
  %31 = load float, ptr addrspace(1) %30, align 4
  %32 = fmul float %28, %31
  call void @llvm.riscv.ventus.barrier(i32 1)
  %33 = extractvalue { ptr addrspace(1), ptr addrspace(1), i64, [1 x i64], [1 x i64] } %8, 1
  %34 = getelementptr float, ptr addrspace(1) %33, i64 %25
  store float %32, ptr addrspace(1) %34, align 4
  ret void
}

declare void @llvm.riscv.ventus.barrier(i32)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
