LLVM_BUILD := ../../../../llvm-project/build
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
MLIR_OPT := ${LLVM_BUILD}/bin/mlir-opt

# Change it to your local path.
VENTUS_INSTALL_PREFIX :=PATH/TO/YOUR/VENTUS_SOFTWARE_STACK/llvm-project/install
VENTUS_SPIKE_BUILD := PATH/TO/YOUR/VENTUS_SOFTWARE_STACK/ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/build
LLC := ${VENTUS_INSTALL_PREFIX}/bin/llc
LD := ${VENTUS_INSTALL_PREFIX}/bin/ld.lld

# Source and target files
GPU_FILE=gpu.mlir
LLVM_DIALECT_FROM_GPU_FILE=llvmDialect_from_gpuDialect.mlir
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

# Target for running RISC-V executable
run-vecadd-riscv: ${OUTPUT_FILE}
	@cp $< ${VENTUS_SPIKE_BUILD}
	@${VENTUS_SPIKE_BUILD}/spike_test

# Clean up generated files
clean:
	rm -f ${LLVM_DIALECT_FILE} ${LL_FILE} ${OBJ_FILE} ${OUTPUT_FILE} vecadd.riscv.log ${LLVM_DIALECT_FROM_GPU_FILE}

.PHONY: get-vecadd-riscv run-vecadd-riscv clean get-llvm-dialect-from-gpu
