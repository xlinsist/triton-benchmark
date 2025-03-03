; ModuleID = '/root/gpu-rodinia/opencl/backprop/backprop_kernel.cl'
source_filename = "/root/gpu-rodinia/opencl/backprop/backprop_kernel.cl"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1"
target triple = "riscv32"

; Function Attrs: convergent norecurse nounwind vscale_range(1,2048)
define dso_local ventus_kernel void @bpnn_layerforward_ocl(ptr addrspace(1) nocapture noundef readonly align 4 %input_cuda, ptr addrspace(1) nocapture noundef readnone align 4 %output_hidden_cuda, ptr addrspace(1) nocapture noundef align 4 %input_hidden_cuda, ptr addrspace(1) nocapture noundef writeonly align 4 %hidden_partial_sum, ptr addrspace(3) nocapture noundef align 4 %input_node, ptr addrspace(3) nocapture noundef align 4 %weight_matrix, i32 noundef %in, i32 noundef %hid) local_unnamed_addr #0 !kernel_arg_addr_space !6 !kernel_arg_access_qual !7 !kernel_arg_type !8 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 {
entry:
  %call = call i32 @_Z12get_group_idj(i32 noundef 1) #4
  %call1 = call i32 @_Z12get_local_idj(i32 noundef 0) #4
  %call2 = call i32 @_Z12get_local_idj(i32 noundef 1) #4
  %add = add nsw i32 %hid, 1
  %mul3 = shl i32 %call, 4
  %reass.add = add i32 %call2, %mul3
  %reass.mul = mul i32 %reass.add, %add
  %add7 = add i32 %hid, 2
  %add8 = add i32 %add7, %call1
  %add10 = add i32 %add8, %reass.mul
  %cmp = icmp eq i32 %call1, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %arrayidx14 = getelementptr inbounds float, ptr addrspace(3) %input_node, i32 %call2
  %add12 = or i32 %mul3, 1
  %add13 = add i32 %add12, %call2
  %arrayidx = getelementptr inbounds float, ptr addrspace(1) %input_cuda, i32 %add13
  %0 = load float, ptr addrspace(1) %arrayidx, align 4, !tbaa !10
  store float %0, ptr addrspace(3) %arrayidx14, align 4, !tbaa !10
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  call void @llvm.riscv.ventus.barrier(i32 1)
  %arrayidx15 = getelementptr inbounds float, ptr addrspace(1) %input_hidden_cuda, i32 %add10
  %1 = load float, ptr addrspace(1) %arrayidx15, align 4, !tbaa !10
  %mul16 = shl nsw i32 %call2, 4
  %add17 = add nsw i32 %mul16, %call1
  %arrayidx18 = getelementptr inbounds float, ptr addrspace(3) %weight_matrix, i32 %add17
  store float %1, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  call void @llvm.riscv.ventus.barrier(i32 1)
  %2 = load float, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  %arrayidx22 = getelementptr inbounds float, ptr addrspace(3) %input_node, i32 %call2
  %3 = load float, ptr addrspace(3) %arrayidx22, align 4, !tbaa !10
  %mul23 = fmul float %2, %3
  store float %mul23, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  call void @llvm.riscv.ventus.barrier(i32 1)
  %4 = load float, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  %add37 = fadd float %4, %4
  store float %add37, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  call void @llvm.riscv.ventus.barrier(i32 1)
  %5 = and i32 %call2, 1
  %cmp28.1 = icmp eq i32 %5, 0
  br i1 %cmp28.1, label %if.then29.1, label %if.end41.1

if.then29.1:                                      ; preds = %if.end
  %6 = load float, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  %add33.1 = shl i32 %call2, 4
  %mul34.1 = add i32 %add33.1, 16
  %add35.1 = add nsw i32 %mul34.1, %call1
  %arrayidx36.1 = getelementptr inbounds float, ptr addrspace(3) %weight_matrix, i32 %add35.1
  %7 = load float, ptr addrspace(3) %arrayidx36.1, align 4, !tbaa !10
  %add37.1 = fadd float %6, %7
  store float %add37.1, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  br label %if.end41.1

if.end41.1:                                       ; preds = %if.then29.1, %if.end
  call void @llvm.riscv.ventus.barrier(i32 1)
  %8 = and i32 %call2, 3
  %cmp28.2 = icmp eq i32 %8, 0
  br i1 %cmp28.2, label %if.then29.2, label %if.end41.2

if.then29.2:                                      ; preds = %if.end41.1
  %9 = load float, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  %add33.2 = shl i32 %call2, 4
  %mul34.2 = add i32 %add33.2, 32
  %add35.2 = add nsw i32 %mul34.2, %call1
  %arrayidx36.2 = getelementptr inbounds float, ptr addrspace(3) %weight_matrix, i32 %add35.2
  %10 = load float, ptr addrspace(3) %arrayidx36.2, align 4, !tbaa !10
  %add37.2 = fadd float %9, %10
  store float %add37.2, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  br label %if.end41.2

if.end41.2:                                       ; preds = %if.then29.2, %if.end41.1
  call void @llvm.riscv.ventus.barrier(i32 1)
  %11 = and i32 %call2, 7
  %cmp28.3 = icmp eq i32 %11, 0
  br i1 %cmp28.3, label %if.then29.3, label %if.end41.3

if.then29.3:                                      ; preds = %if.end41.2
  %12 = load float, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  %add33.3 = shl i32 %call2, 4
  %mul34.3 = add i32 %add33.3, 64
  %add35.3 = add nsw i32 %mul34.3, %call1
  %arrayidx36.3 = getelementptr inbounds float, ptr addrspace(3) %weight_matrix, i32 %add35.3
  %13 = load float, ptr addrspace(3) %arrayidx36.3, align 4, !tbaa !10
  %add37.3 = fadd float %12, %13
  store float %add37.3, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  br label %if.end41.3

if.end41.3:                                       ; preds = %if.then29.3, %if.end41.2
  call void @llvm.riscv.ventus.barrier(i32 1)
  %14 = and i32 %call2, 15
  %cmp28.4 = icmp eq i32 %14, 0
  br i1 %cmp28.4, label %if.then29.4, label %if.end41.4

if.then29.4:                                      ; preds = %if.end41.3
  %15 = load float, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  %add33.4 = shl i32 %call2, 4
  %mul34.4 = add i32 %add33.4, 128
  %add35.4 = add nsw i32 %mul34.4, %call1
  %arrayidx36.4 = getelementptr inbounds float, ptr addrspace(3) %weight_matrix, i32 %add35.4
  %16 = load float, ptr addrspace(3) %arrayidx36.4, align 4, !tbaa !10
  %add37.4 = fadd float %15, %16
  store float %add37.4, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  br label %if.end41.4

if.end41.4:                                       ; preds = %if.then29.4, %if.end41.3
  call void @llvm.riscv.ventus.barrier(i32 1)
  %17 = load float, ptr addrspace(3) %arrayidx18, align 4, !tbaa !10
  store float %17, ptr addrspace(1) %arrayidx15, align 4, !tbaa !10
  call void @llvm.riscv.ventus.barrier(i32 1)
  br i1 %cmp, label %if.then48, label %if.end55

if.then48:                                        ; preds = %if.end41.4
  %mul52 = mul nsw i32 %call, %hid
  %add53 = add nsw i32 %call2, %mul52
  %arrayidx54 = getelementptr inbounds float, ptr addrspace(1) %hidden_partial_sum, i32 %add53
  %arrayidx51 = getelementptr inbounds float, ptr addrspace(3) %weight_matrix, i32 %call2
  %18 = load float, ptr addrspace(3) %arrayidx51, align 4, !tbaa !10
  store float %18, ptr addrspace(1) %arrayidx54, align 4, !tbaa !10
  br label %if.end55

if.end55:                                         ; preds = %if.then48, %if.end41.4
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare dso_local i32 @_Z12get_group_idj(i32 noundef) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare dso_local i32 @_Z12get_local_idj(i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @llvm.riscv.ventus.barrier(i32 immarg) #2

; Function Attrs: convergent norecurse nounwind vscale_range(1,2048)
define dso_local ventus_kernel void @bpnn_adjust_weights_ocl(ptr addrspace(1) nocapture noundef readonly align 4 %delta, i32 noundef %hid, ptr addrspace(1) nocapture noundef readonly align 4 %ly, i32 noundef %in, ptr addrspace(1) nocapture noundef align 4 %w, ptr addrspace(1) nocapture noundef align 4 %oldw) local_unnamed_addr #0 !kernel_arg_addr_space !14 !kernel_arg_access_qual !15 !kernel_arg_type !16 !kernel_arg_base_type !16 !kernel_arg_type_qual !17 {
entry:
  %call = call i32 @_Z12get_group_idj(i32 noundef 1) #4
  %call1 = call i32 @_Z12get_local_idj(i32 noundef 0) #4
  %call2 = call i32 @_Z12get_local_idj(i32 noundef 1) #4
  %add = add nsw i32 %hid, 1
  %mul3 = shl i32 %call, 4
  %reass.add = add i32 %call2, %mul3
  %reass.mul = mul i32 %reass.add, %add
  %add7 = add i32 %call1, 1
  %add8 = add i32 %add7, %add
  %add10 = add i32 %add8, %reass.mul
  %add12 = or i32 %mul3, 1
  %add13 = add i32 %add12, %call2
  %arrayidx = getelementptr inbounds float, ptr addrspace(1) %delta, i32 %add7
  %0 = load float, ptr addrspace(1) %arrayidx, align 4, !tbaa !10
  %mul15 = fmul float %0, 0x3FD3333340000000
  %arrayidx16 = getelementptr inbounds float, ptr addrspace(1) %ly, i32 %add13
  %1 = load float, ptr addrspace(1) %arrayidx16, align 4, !tbaa !10
  %arrayidx18 = getelementptr inbounds float, ptr addrspace(1) %oldw, i32 %add10
  %2 = load float, ptr addrspace(1) %arrayidx18, align 4, !tbaa !10
  %mul19 = fmul float %2, 0x3FD3333340000000
  %3 = call float @llvm.fmuladd.f32(float %mul15, float %1, float %mul19)
  %arrayidx20 = getelementptr inbounds float, ptr addrspace(1) %w, i32 %add10
  %4 = load float, ptr addrspace(1) %arrayidx20, align 4, !tbaa !10
  %add21 = fadd float %4, %3
  store float %add21, ptr addrspace(1) %arrayidx20, align 4, !tbaa !10
  %5 = load float, ptr addrspace(1) %arrayidx, align 4, !tbaa !10
  %mul23 = fmul float %5, 0x3FD3333340000000
  %6 = load float, ptr addrspace(1) %arrayidx16, align 4, !tbaa !10
  %7 = load float, ptr addrspace(1) %arrayidx18, align 4, !tbaa !10
  %mul27 = fmul float %7, 0x3FD3333340000000
  %8 = call float @llvm.fmuladd.f32(float %mul23, float %6, float %mul27)
  store float %8, ptr addrspace(1) %arrayidx18, align 4, !tbaa !10
  call void @llvm.riscv.ventus.barrier(i32 1)
  %cmp = icmp eq i32 %call2, 0
  %cmp29 = icmp eq i32 %call, 0
  %or.cond = select i1 %cmp, i1 %cmp29, i1 false
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %9 = load float, ptr addrspace(1) %arrayidx, align 4, !tbaa !10
  %arrayidx32 = getelementptr inbounds float, ptr addrspace(1) %oldw, i32 %add7
  %10 = load float, ptr addrspace(1) %arrayidx32, align 4, !tbaa !10
  %mul33 = fmul float %10, 0x3FD3333340000000
  %11 = call float @llvm.fmuladd.f32(float %9, float 0x3FD3333340000000, float %mul33)
  %arrayidx34 = getelementptr inbounds float, ptr addrspace(1) %w, i32 %add7
  %12 = load float, ptr addrspace(1) %arrayidx34, align 4, !tbaa !10
  %add35 = fadd float %12, %11
  store float %add35, ptr addrspace(1) %arrayidx34, align 4, !tbaa !10
  %13 = load float, ptr addrspace(1) %arrayidx, align 4, !tbaa !10
  %14 = load float, ptr addrspace(1) %arrayidx32, align 4, !tbaa !10
  %mul39 = fmul float %14, 0x3FD3333340000000
  %15 = call float @llvm.fmuladd.f32(float %13, float 0x3FD3333340000000, float %mul39)
  store float %15, ptr addrspace(1) %arrayidx32, align 4, !tbaa !10
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #3

attributes #0 = { convergent norecurse nounwind vscale_range(1,2048) "disable-tail-calls"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="ventus-gpgpu" "target-features"="+32bit,+a,+m,+relax,+zdinx,+zfinx,+zhinx,+zve32f,+zve32x,+zvl32b,-64bit,-save-restore" "uniform-work-group-size"="false" }
attributes #1 = { convergent mustprogress nofree nounwind willreturn memory(none) "disable-tail-calls"="true" "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="ventus-gpgpu" "target-features"="+32bit,+a,+m,+relax,+zdinx,+zfinx,+zhinx,+zve32f,+zve32x,+zvl32b,-64bit,-save-restore" }
attributes #2 = { nounwind }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { convergent nounwind willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3}
!opencl.ocl.version = !{!4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"ilp32"}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 1, !"SmallDataLimit", i32 8}
!4 = !{i32 2, i32 0}
!5 = !{!"clang version 16.0.0 (https://github.com/THU-DSP-LAB/llvm-project.git 0f31d6ca085de0b69ab06e00b0add1cbe1b2b7ed)"}
!6 = !{i32 1, i32 1, i32 1, i32 1, i32 3, i32 3, i32 0, i32 0}
!7 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!8 = !{!"float*", !"float*", !"float*", !"float*", !"float*", !"float*", !"int", !"int"}
!9 = !{!"", !"", !"", !"", !"", !"", !"", !""}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{i32 1, i32 0, i32 1, i32 0, i32 1, i32 1}
!15 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!16 = !{!"float*", !"int", !"float*", !"int", !"float*", !"float*"}
!17 = !{!"", !"", !"", !"", !"", !""}
