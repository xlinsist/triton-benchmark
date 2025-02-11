# The commit id of triton used here is `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`.
# The corresponding commit id of llvm-project is `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`.
TRITON_BUILD := ../../../../triton/python/build/cmake.linux-x86_64-cpython-3.10
LLVM_BUILD := ../../../../llvm-project/build

TRITON_OPT := ${TRITON_BUILD}/bin/triton-opt
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
LLVM_LLC := ${LLVM_BUILD}/bin/llc

# The combination of passes is not unique.
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

PASSES_FLAGS_MINIMUM = --tritongpu-combine-tensor-select-and-if  \
	--convert-scf-to-cf \
	--convert-index-to-llvm \
	--allocate-shared-memory \
	--convert-triton-gpu-to-llvm\
	--canonicalize \

all: matmul_kernel_manual_convert_to_llvm matmul_kernel_manual_translate_to_llvmir matmul_kernel_manual_generate_ptx

# The generated `matmul_kernel_manual.mlir` contains ops like `nvvm.barrier0`, `nvvm.read.ptx.sreg.tid.x` and `llvm.inline_asm`
matmul_kernel_manual_convert_to_llvm: matmul_kernel.ttgir
	@${TRITON_OPT} ${PASSES_FLAGS_MINIMUM} --o matmul_kernel_manual.mlir $<
	@${TRITON_OPT} matmul_kernel_manual.mlir --print-op-stats > /dev/null

matmul_kernel_manual_translate_to_llvmir: matmul_kernel_manual.mlir
	@${MLIR_TRANSLATE} --mlir-to-llvmir -o matmul_kernel_manual.ll $<

matmul_kernel_manual_generate_ptx: matmul_kernel_manual.ll
	@${LLVM_LLC} -march=nvptx64 -o matmul_kernel_manual.ptx $<

# FIXME: Got error "<unknown>:0: error: unhandled value: ptr asm "mov.u32 $0, %ctaid.x;", "=r"",
# seems like a bug in llvm-translate
matmul_kernel_manual_import_llvm: matmul_kernel_manual.ll
	@${MLIR_TRANSLATE} --import-llvm -o matmul_kernel_manual_import_llvm.mlir $<
