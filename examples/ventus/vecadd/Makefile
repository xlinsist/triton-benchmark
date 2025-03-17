# The commit id of triton used here is `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`.
# The corresponding commit id of llvm-project is `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`.
LLVM_BUILD := ${LLVM_BUILD_DIR}
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
MLIR_OPT := ${LLVM_BUILD}/bin/mlir-opt

# Change it to your local path.
VENTUS_SPIKE_BUILD := ${SPIKE_SRC_DIR}/gpgpu-testcase/driver/build
LLC := ${VENTUS_INSTALL_PREFIX}/bin/llc
LD := ${VENTUS_INSTALL_PREFIX}/bin/ld.lld

# Source and target files
GPU_FILE=gpu.mlir
LLVM_DIALECT_FROM_GPU_FILE=gpu_llvm_dialect.mlir
MLIR_FILE=vecadd.mlir
LLVM_DIALECT_FILE=vecadd_llvm_dialect.mlir
LL_FILE=vecadd.ll
OBJ_FILE=vecadd.o
OUTPUT_FILE=vecadd.riscv

# Rules for generating LLVM Dialect file from GPU file
# Note: The generated LLVM Dialect file need delete "gpu.module @kernels {" , and one "}" mannually
${LLVM_DIALECT_FROM_GPU_FILE}: ${GPU_FILE}
	@${MLIR_OPT} $< --convert-gpu-to-llvm-spv --convert-arith-to-llvm --convert-func-to-llvm=use-bare-ptr-memref-call-conv=true -finalize-memref-to-llvm -o $@

get-llvm-dialect-from-gpu: ${LLVM_DIALECT_FROM_GPU_FILE}
	@echo "Generated LLVM Dialect file from GPU successfully."

# Rules for generating LLVM Dialect file
${LLVM_DIALECT_FILE}: ${MLIR_FILE}
	@${MLIR_OPT} $< --pass-pipeline="builtin.module(convert-func-to-llvm{use-bare-ptr-memref-call-conv=true },convert-arith-to-llvm,finalize-memref-to-llvm,reconcile-unrealized-casts)" -o $@

# Rules for generating LLVM IR file
# Note: use sed to add 'ventus_kernel'
${LL_FILE}: ${LLVM_DIALECT_FILE}
	@${MLIR_TRANSLATE} -mlir-to-llvmir $< -o $@
	@sed -i 's/define void @vectorAdd/define ventus_kernel void @vectorAdd/' $@

# Rules for generating object file
${OBJ_FILE}: ${LL_FILE}
	@${LLC} -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj $< -o $@

# Rules for generating RISC-V executable
${OUTPUT_FILE}: ${OBJ_FILE}
	@${LD} -o $@ -T ${VENTUS_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld $< ${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o -L ${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init vectorAdd

# Target for getting RISC-V executable
get-vecadd-riscv: ${OUTPUT_FILE}

# Pass RISC-V executable to the driver
pass-to-driver:
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make
	@find ${SPIKE_SRC_DIR}/gpgpu-testcase/driver/build/ -type f -name "*.riscv" -delete
	@cp test.cpp ${SPIKE_SRC_DIR}/gpgpu-testcase/driver/test.cpp
	@cp ${OUTPUT_FILE} ${SPIKE_SRC_DIR}/gpgpu-testcase/driver/build/${OUTPUT_FILE}
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make clean

# Run RISC-V executable on the driver
run-vecadd-riscv:
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make all
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make run

# Clean up generated files
clean:
	rm -f ${LLVM_DIALECT_FILE} ${LL_FILE} ${OBJ_FILE} ${OUTPUT_FILE} ${LLVM_DIALECT_FROM_GPU_FILE} vecadd.riscv.log

.PHONY: get-vecadd-riscv run-vecadd-riscv clean
