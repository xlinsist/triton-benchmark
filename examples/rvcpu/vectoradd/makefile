# The commit id of triton-cpu used here is `7d16b21e92f215bafd3b711720783c114252b0b3`.
TRITON_BUILD := /home/zhouxulin/intern/triton-cpu/python/build/cmake.linux-x86_64-cpython-3.10
LLVM_BUILD := /home/zhouxulin/intern/buddy-mlir/llvm/build

TRITON_OPT := ${TRITON_BUILD}/bin/triton-opt
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate

# `log.mlir` generated here is similar to `add_kernel.tttcir`
ttcir-lower-to-tttcir:
	@${TRITON_OPT} ./add_kernel.ttcir \
        --triton-cpu-scalarize \
        --triton-cpu-convert-memory-ops \
        --triton-cpu-convert-ptr-ops \
        --triton-cpu-convert-elementwise-ops \
        --triton-cpu-convert-elem-manip-ops \
        --triton-cpu-convert-dot-op \
        --triton-cpu-convert-histogram-op \
        --triton-cpu-convert-reduction \
        --triton-cpu-convert-scan \
        --triton-cpu-convert-control-flow-op \
        --triton-cpu-convert-atomic-ops \
        --triton-cpu-convert-debug-ops \
        --cse \
        --symbol-dce \
        --canonicalize \
        --triton-cpu-optimize-masks \
        --canonicalize \
        --triton-cpu-add-casts-for-unsupported-ops \
        --triton-cpu-decompose-fp-conversions \
        --cse \
        --symbol-dce \
        --canonicalize \
        --o log.mlir
	@${TRITON_OPT} log.mlir --print-op-stats > /dev/null

# `log.ll` generated here is similar to `add_kernel.llir`
ttcir-lower-to-llvm:
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
	@${TRITON_OPT} log.mlir --print-op-stats > /dev/null

ttcir-lower-to-llvm-simple-pipeline:
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
