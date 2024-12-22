; Generated directly using clang from ventus llvm. See README in https://github.com/THU-DSP-LAB/llvm-project.

; ModuleID = 'vecadd.cl'
source_filename = "vecadd.cl"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1"
target triple = "riscv32"

; Function Attrs: convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) vscale_range(1,2048)

; FIXME: !!! `dso_local` and `ventus_kernel` are manually removed !!!
; define dso_local ventus_kernel void @vectorAdd(ptr addrspace(1) nocapture noundef align 4 %A, ptr addrspace(1) nocapture noundef readonly align 4 %B) local_unnamed_addr #0 !kernel_arg_addr_space !6 !kernel_arg_access_qual !7 !kernel_arg_type !8 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 {
define void @vectorAdd(ptr addrspace(1) nocapture noundef align 4 %A, ptr addrspace(1) nocapture noundef readonly align 4 %B) local_unnamed_addr #0 !kernel_arg_addr_space !6 !kernel_arg_access_qual !7 !kernel_arg_type !8 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 {
entry:
  %call = call i32 @_Z13get_global_idj(i32 noundef 0) #2
  %arrayidx = getelementptr inbounds float, ptr addrspace(1) %B, i32 %call
  %0 = load float, ptr addrspace(1) %arrayidx, align 4, !tbaa !10
  %arrayidx1 = getelementptr inbounds float, ptr addrspace(1) %A, i32 %call
  %1 = load float, ptr addrspace(1) %arrayidx1, align 4, !tbaa !10
  %add = fadd float %0, %1
  store float %add, ptr addrspace(1) %arrayidx1, align 4, !tbaa !10
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare dso_local i32 @_Z13get_global_idj(i32 noundef) local_unnamed_addr #1

attributes #0 = { convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) vscale_range(1,2048) "disable-tail-calls"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="ventus-gpgpu" "target-features"="+32bit,+a,+m,+relax,+zdinx,+zfinx,+zhinx,+zve32f,+zve32x,+zvl32b,-64bit,-save-restore" "uniform-work-group-size"="false" }
attributes #1 = { convergent mustprogress nofree nounwind willreturn memory(none) "disable-tail-calls"="true" "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="ventus-gpgpu" "target-features"="+32bit,+a,+m,+relax,+zdinx,+zfinx,+zhinx,+zve32f,+zve32x,+zvl32b,-64bit,-save-restore" }
attributes #2 = { convergent nounwind willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3}
!opencl.ocl.version = !{!4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"ilp32"}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 1, !"SmallDataLimit", i32 8}
!4 = !{i32 2, i32 0}
!5 = !{!"clang version 16.0.0 (git@github.com:xlinsist/llvm-project.git 0a82f17b0c225e65f89d6dbbc3093063a0ec267f)"}
!6 = !{i32 1, i32 1}
!7 = !{!"none", !"none"}
!8 = !{!"float*", !"float*"}
!9 = !{!"", !""}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
