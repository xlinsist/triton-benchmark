#tbaa_root = #llvm.tbaa_root<id = "Simple C/C++ TBAA">
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "omnipotent char", members = {<#tbaa_root, 0>}>
#tbaa_type_desc1 = #llvm.tbaa_type_desc<id = "float", members = {<#tbaa_type_desc, 0>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc1, access_type = #tbaa_type_desc1, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<i32 = dense<32> : vector<2xi64>, f16 = dense<16> : vector<2xi64>, f64 = dense<64> : vector<2xi64>, i1 = dense<8> : vector<2xi64>, i16 = dense<16> : vector<2xi64>, i8 = dense<8> : vector<2xi64>, !llvm.ptr = dense<32> : vector<4xi64>, f128 = dense<128> : vector<2xi64>, i64 = dense<64> : vector<2xi64>, "dlti.endianness" = "little", "dlti.global_memory_space" = 1 : ui64, "dlti.stack_alignment" = 128 : i64, "dlti.alloca_memory_space" = 5 : ui64>, llvm.ident = "clang version 16.0.0 (git@github.com:xlinsist/llvm-project.git 0a82f17b0c225e65f89d6dbbc3093063a0ec267f)"} {
  llvm.func local_unnamed_addr @vectorAdd(%arg0: !llvm.ptr<1> {llvm.align = 4 : i64, llvm.nocapture, llvm.noundef}, %arg1: !llvm.ptr<1> {llvm.align = 4 : i64, llvm.nocapture, llvm.noundef, llvm.readonly}) vscale_range(1, 2048) attributes {convergent, frame_pointer = #llvm.framePointerKind<all>, memory_effects = #llvm.memory_effects<other = none, argMem = readwrite, inaccessibleMem = none>, no_unwind, passthrough = ["mustprogress", "nofree", "norecurse", ["disable-tail-calls", "true"], ["min-legal-vector-width", "0"], ["no-trapping-math", "true"], ["stack-protector-buffer-size", "8"], ["target-cpu", "ventus-gpgpu"], ["uniform-work-group-size", "false"]], target_cpu = "ventus-gpgpu", target_features = #llvm.target_features<["+32bit", "+a", "+m", "+relax", "+zdinx", "+zfinx", "+zhinx", "+zve32f", "+zve32x", "+zvl32b", "-64bit", "-save-restore"]>, will_return} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @_Z13get_global_idj(%0) {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, no_unwind, will_return} : (i32) -> i32
    %2 = llvm.getelementptr inbounds %arg1[%1] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %3 = llvm.load %2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr<1> -> f32
    %4 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %5 = llvm.load %4 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr<1> -> f32
    %6 = llvm.fadd %3, %5 : f32
    llvm.store %6, %4 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : f32, !llvm.ptr<1>
    llvm.return
  }
  llvm.func local_unnamed_addr @_Z13get_global_idj(i32 {llvm.noundef}) -> i32 attributes {convergent, frame_pointer = #llvm.framePointerKind<all>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, no_unwind, passthrough = ["mustprogress", "nofree", ["disable-tail-calls", "true"], ["no-trapping-math", "true"], ["stack-protector-buffer-size", "8"], ["target-cpu", "ventus-gpgpu"]], target_cpu = "ventus-gpgpu", target_features = #llvm.target_features<["+32bit", "+a", "+m", "+relax", "+zdinx", "+zfinx", "+zhinx", "+zve32f", "+zve32x", "+zvl32b", "-64bit", "-save-restore"]>, will_return}
}
