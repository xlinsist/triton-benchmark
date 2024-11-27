TRITON_OPT := /home/zhouxulin/intern/triton-cpu/python/build/cmake.linux-x86_64-cpython-3.10/bin/triton-opt
# TRITON_GPU_OPT := /home/zhouxulin/intern/triton/python/build/cmake.linux-x86_64-cpython-3.12/bin/triton-opt
MLIR_OPT := /home/zhouxulin/intern/buddy-mlir/llvm/build/bin/mlir-opt
MLIR_TRANSLATE := /home/zhouxulin/intern/buddy-mlir/llvm/build/bin/mlir-translate

tttcir-lowering-full:
	@${TRITON_OPT} ./add_kernel.tttcir \
        --triton-cpu-lower-multi-reduction \
        --convert-vector-to-scf \
        --lower-affine \
        --convert-scf-to-cf \
        --convert-index-to-llvm \
        --triton-cpu-func-op-to-llvm \
        --triton-cpu-get-program-id-op-to-llvm \
        --triton-cpu-memory-op-to-llvm \
        --triton-cpu-atomic-ops-to-llvm \
        --triton-cpu-debug-ops-to-llvm \
        --triton-cpu-math-to-vec-lib \
        --convert-math-to-llvm \
        --convert-math-to-libm \
        --convert-vector-to-llvm \
        --finalize-memref-to-llvm \
        --convert-arith-to-llvm \
        --convert-func-to-llvm \
        --canonicalize \
        --cse \
        --symbol-dce \
        --o log.mlir

tttcir-lowering:
	@${TRITON_OPT} ./add_kernel.tttcir \
        --convert-vector-to-scf \
        --lower-affine \
        --convert-scf-to-cf \
        --convert-index-to-llvm | \
    ${TRITON_OPT} \
        --triton-cpu-memory-op-to-llvm | \
    ${TRITON_OPT} \
        --convert-math-to-llvm \
        --convert-math-to-libm \
        --convert-vector-to-llvm \
        --finalize-memref-to-llvm \
        --convert-arith-to-llvm \
        --convert-func-to-llvm \
        --canonicalize \
        --cse \
        --symbol-dce \
        --o log.mlir
