// Generated from running `python ./iree/tests/e2e/matmul/generate_e2e_matmul_tests.py --output_matmul_mlir=matmul.mlir --output_calls_mlir=calls.mlir --lhs_rhs_type=f16 --acc_type=f16 --shapes=easy_large_static --compilation_info=LLVMGPUMatmulTensorCore`, where only `TestShape(m=512, k=128, n=512, accumulate=True)` enabled

#compilation0 = #iree_codegen.compilation_info<
  lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 32, 16]]>,
  translation_info = #iree_codegen.translation_info<pipeline = LLVMGPUMatmulTensorCore workgroup_size = [64, 2, 1]
  ,
  { pipeline_depth = 3, store_stage = 1}>>func.func @matmul_accumulate_512x128xf16_times_128x512xf16_into_512x512xf16_for_LLVMGPUMatmulTensorCore(%lhs: tensor<512x128xf16>, %rhs: tensor<128x512xf16>, %acc: tensor<512x512xf16>) -> tensor<512x512xf16> {
  %result = linalg.matmul {compilation_info = #compilation0} ins(%lhs, %rhs: tensor<512x128xf16>, tensor<128x512xf16>) outs(%acc: tensor<512x512xf16>) -> tensor<512x512xf16>

  return %result: tensor<512x512xf16>
}

