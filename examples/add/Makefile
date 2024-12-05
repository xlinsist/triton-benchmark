TRITON_OPT := ${TRITON_BUILD}/bin/triton-opt
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate

ttgir_to_llvmdialect:
	@${TRITON_OPT} ./add_kernel.ttgir \
        --convert-vector-to-scf  \ 
        --lower-affine   \
        --convert-scf-to-cf  \ 
        --convert-index-to-llvm  \
        --convert-triton-gpu-to-llvm  \
        --convert-func-to-llvm   \
        --convert-vector-to-llvm  \
        --o  add_kernel.mlir

llvmdialect_to_llvmir:
        @${MLIR_TRANSLATE} ./add_kernel.mlir \
        --mlir-to-llvmir   \
         -o  add_kernel.llir




