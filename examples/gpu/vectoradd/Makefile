# The commit id of triton used here is `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`.
# The corresponding commit id of llvm-project is `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`.
TRITON_BUILD := ../../../../triton/python/build/cmake.linux-x86_64-cpython-3.10
LLVM_BUILD := ../../../../llvm-project/build

TRITON_OPT := ${TRITON_BUILD}/bin/triton-opt
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
LLVM_LLC := ${LLVM_BUILD}/bin/llc

# The combination of passes is not unique.
PASSES_FLAGS =	--decompose-unsupported-nvidia-conversions \
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

PASSES_FLAGS_MINIMUM = --convert-triton-gpu-to-llvm \
	--canonicalize \

all: add_kernel_manual_convert_to_llvm add_kernel_manual_translate_to_llvmir add_kernel_manual_generate_ptx

# The generated `add_kernel_manual.mlir` contains ops like `nvvm.read.ptx.sreg.tid.x` and `llvm.inline_asm`
add_kernel_manual_convert_to_llvm: add_kernel.ttgir
	@${TRITON_OPT} ${PASSES_FLAGS_MINIMUM} --o add_kernel_manual.mlir $<
	@${TRITON_OPT} add_kernel_manual.mlir --print-op-stats > /dev/null

add_kernel_manual_translate_to_llvmir: add_kernel_manual.mlir
	@${MLIR_TRANSLATE} --mlir-to-llvmir -o add_kernel_manual.ll $<

add_kernel_manual_generate_ptx: add_kernel_manual.ll
	@${LLVM_LLC} -march=nvptx64 -o add_kernel_manual.ptx $<

# FIXME: Got error "<unknown>:0: error: unhandled value: ptr asm "mov.u32 $0, %ctaid.x;", "=r"",
# seems like a bug in llvm-translate
add_kernel_manual_import_llvm: add_kernel_manual.ll
	@${MLIR_TRANSLATE} --import-llvm -o add_kernel_manual_import_llvm.mlir $<
