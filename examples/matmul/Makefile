TRITON_OPT := ${TRITON_BUILD}/bin/triton-opt
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
LLVM_LLC := ${LLVM_BUILD}/bin/llc

PASSES_FLAGS = 	--decompose-unsupported-nvidia-conversions \
	--tritongpu-combine-tensor-select-and-if \
	--convert-scf-to-cf --convert-index-to-llvm \
	--allocate-shared-memory \
	--tritongpu-global-scratch-memory-allocation \
	--convert-triton-gpu-to-llvm \
	--convert-nvgpu-to-nvvm \
	--convert-nvvm-to-llvm \
	--convert-arith-to-llvm \
	--canonicalize \
	--cse \
	--symbol-dce \

matmul.llir: matmul.ttgir
	${TRITON_OPT} ${PASSES_FLAGS} --o $@ $<

matmul_m.ll: matmul.llir
	${MLIR_TRANSLATE} --mlir-to-llvmir -o $@ $<

matmul.ptx: matmul_m.ll
	${LLVM_LLC} -march=nvptx64 $< -o $@
