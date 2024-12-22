; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1"
target triple = "riscv32"

declare i32 @_Z13get_global_idj(i32)

; FIXME: Should it be `define ventus_kernel void @vecadd(...)`???
define void @vecadd(ptr addrspace(1) %0, ptr addrspace(1) %1, ptr addrspace(1) %2) {
  %4 = call i32 @_Z13get_global_idj(i32 0)
  %5 = getelementptr float, ptr addrspace(1) %0, i32 %4
  %6 = load float, ptr addrspace(1) %5, align 4
  %7 = getelementptr float, ptr addrspace(1) %1, i32 %4
  %8 = load float, ptr addrspace(1) %7, align 4
  %9 = fadd float %6, %8
  %10 = getelementptr float, ptr addrspace(1) %2, i32 %4
  store float %9, ptr addrspace(1) %10, align 4
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
