# Refer https://iree.dev/building-from-source/getting-started/#optional-components to build IREE from source with CUDA enabled.
# Commit id of IREE: 10e5bbbed2
IREE_TOOL_CHAINS := /home/zhouxulin/intern/iree/iree-build/tools
IREE_E2E_MATMUL_PATH := /home/zhouxulin/intern/iree/tests/e2e/matmul

log-e2e.mlir: matmul.mlir
	@-exec > log-e2e.mlir 2>&1; \
	${IREE_TOOL_CHAINS}/iree-compile \
		--iree-hal-target-backends=cuda \
		--iree-cuda-target=sm_80 \
		--mlir-disable-threading --mlir-elide-elementsattrs-if-larger=10 --mlir-print-ir-after-all --mlir-print-ir-after-change --mlir-print-ir-before-all \
		matmul.mlir -o matmul.vmfb
