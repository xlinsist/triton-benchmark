; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-G1-S128-A5-i32:32-f16:16-f64:64-i1:8-i16:16-i8:8-p0:32:32:32:32-f128:128-i64:64"

; Function Attrs: convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) vscale_range(1,2048)
define void @vectorAdd(ptr addrspace(1) nocapture noundef align 4 %0, ptr addrspace(1) nocapture noundef readonly align 4 %1) local_unnamed_addr #0 {
  %3 = call i32 @_Z13get_global_idj(i32 0) #2
  %4 = getelementptr inbounds float, ptr addrspace(1) %1, i32 %3
  %5 = load float, ptr addrspace(1) %4, align 4, !tbaa !2
  %6 = getelementptr inbounds float, ptr addrspace(1) %0, i32 %3
  %7 = load float, ptr addrspace(1) %6, align 4, !tbaa !2
  %8 = fadd float %5, %7
  store float %8, ptr addrspace(1) %6, align 4, !tbaa !2
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @_Z13get_global_idj(i32 noundef) local_unnamed_addr #1

attributes #0 = { convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) vscale_range(1,2048) "disable-tail-calls"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="ventus-gpgpu" "target-features"="+32bit,+a,+m,+relax,+zdinx,+zfinx,+zhinx,+zve32f,+zve32x,+zvl32b,-64bit,-save-restore" "uniform-work-group-size"="false" }
attributes #1 = { convergent mustprogress nofree nounwind willreturn memory(none) "disable-tail-calls"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="ventus-gpgpu" }
attributes #2 = { convergent nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{!"clang version 16.0.0 (git@github.com:xlinsist/llvm-project.git 0a82f17b0c225e65f89d6dbbc3093063a0ec267f)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"float", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
