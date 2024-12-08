# The commit id of triton used here is `cf34004b8a67d290a962da166f5aa2fc66751326`.
# The corresponding commit id of llvm-project is `10dc3a8e916d73291269e5e2b82dd22681489aa1`.

TRITON_BUILD := ~/workplace/triton/python/build/cmake.linux-x86_64-cpython-3.10
LLVM_BUILD := ~/workplace/llvm-project/build

TRITON_OPT := $(TRITON_BUILD)/bin/triton-opt
MLIR_TRANSLATE := $(LLVM_BUILD)/bin/mlir-translate
LLVM_LLC := $(LLVM_BUILD)/bin/llc

# The combination of passes is not unique.
PASSES_FLAGS := --convert-vector-to-scf \
                --lower-affine \
                --convert-scf-to-cf \
                --convert-index-to-llvm \
                --tritongpu-combine-tensor-select-and-if \
                --decompose-unsupported-nvidia-conversions \
                --allocate-shared-memory \
                --convert-triton-gpu-to-llvm \
                --convert-func-to-llvm \
                --convert-vector-to-llvm

#make tritongpu dialect to llvm dialect
softmax_kernel_llvm.mlir: softmax_kernel.ttgir
	@$(TRITON_OPT) $(PASSES_FLAGS) --o $@ $<

#make llvm dialect to llvm ir
softmax_kernel.ll: softmax_kernel_llvm.mlir
	@$(MLIR_TRANSLATE) --mlir-to-llvmir -o $@ $<

#make llvm ir to NVIDIA GPU PTX code (-march=nvptx64) 
softmax_kernel.ptx: softmax_kernel.ll
        @${LLVM_LLC} -march=nvptx64 -o $@ $<

