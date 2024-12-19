# The commit id of triton used here is `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`.
# The corresponding commit id of llvm-project is `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`.
LLVM_BUILD := ~/llvm-project/build
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
MLIR_OPT := ${LLVM_BUILD}/bin/mlir-opt

# Paths, need modify
LLVM_INSTALL_PREFIX :=~/dev/gpgpu/llvm-project/install
LLVM_SPIKE_BUILD := ~/dev/gpgpu/ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/build


LLC := ${LLVM_INSTALL_PREFIX}/bin/llc
LD := ${LLVM_INSTALL_PREFIX}/bin/ld.lld

# Source and target files
MLIR_FILE=vecadd_high_dialects.mlir
LLVM_DIALECT_FILE=vecadd_llvm_dialect.mlir
LL_FILE=vecadd.ll
OBJ_FILE=vecadd.o
OUTPUT_FILE=vecadd.riscv


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
	@${LD} -o $@ -T ${LLVM_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld $< ${LLVM_INSTALL_PREFIX}/lib/crt0.o ${LLVM_INSTALL_PREFIX}/lib/riscv32clc.o -L ${LLVM_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init vectorAdd

# Target for getting RISC-V executable
get-vecadd-riscv: ${OUTPUT_FILE}

# Target for running RISC-V executable
// NOTE: must replace 'test.cpp' in the current directory with 'ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/test.cpp' beforehand and successfully build the 'build' directory.
// NOTE: must build the 'build' directory under the 'driver' directory beforehand.
run-vecadd-riscv: ${OUTPUT_FILE}
	@cp $< ${LLVM_SPIKE_BUILD}
	@${LLVM_SPIKE_BUILD}/spike_test

# Clean up generated files
clean:
	rm -f ${LLVM_DIALECT_FILE} ${LL_FILE} ${OBJ_FILE} ${OUTPUT_FILE} vecadd.riscv.log

.PHONY: get-vecadd-riscv run-vecadd-riscv clean
