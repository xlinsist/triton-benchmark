# The commit id of triton used here is `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`.
# The corresponding commit id of llvm-project is `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`.
LLVM_BUILD := ${LLVM_BUILD_DIR}
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
MLIR_OPT := ${LLVM_BUILD}/bin/mlir-opt

# Change it to your local path.
VENTUS_SPIKE_BUILD := ~/myProject/ventus-toolchain/ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/build
LLC := ${VENTUS_INSTALL_PREFIX}/bin/llc
LD := ${VENTUS_INSTALL_PREFIX}/bin/ld.lld

# Source and target files
MLIR_FILE=backprop.mlir
LLVM_DIALECT_FILE=backprop_llvm_dialect.mlir
LL_FILE=backprop.ll
OBJ_FILE=backprop.o
OUTPUT_FILE=backprop.riscv

# Rules for generating LLVM Dialect file
# scf.for -> cd --> llvm is added
${LLVM_DIALECT_FILE}: ${MLIR_FILE}
	@${MLIR_OPT} $< --pass-pipeline="builtin.module(convert-func-to-llvm{use-bare-ptr-memref-call-conv=true},convert-scf-to-cf,convert-cf-to-llvm,convert-arith-to-llvm,finalize-memref-to-llvm,reconcile-unrealized-casts)" -o $@
	@echo ">>> .mlir --> mlir-dialect"
# Rules for generating LLVM IR file
# Note: use sed to add 'ventus_kernel'

${LL_FILE}: ${LLVM_DIALECT_FILE}
	@${MLIR_TRANSLATE} -mlir-to-llvmir $< -o $@
	@sed -i 's/define void @backprop/define ventus_kernel void @backprop/' $@
	@echo ">>> mlir-dialect --> .ll"

# Rules for generating object file
${OBJ_FILE}: ${LL_FILE}
	@${LLC} -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj $< -o $@
	@echo ">>> .ll --> .obj"

# Rules for generating RISC-V executable
${OUTPUT_FILE}: ${OBJ_FILE}
	@${LD} -o $@ -T ${VENTUS_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld $< ${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o -L ${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init backprop
	@echo ">>> .obj --> .riscv"
# Target for getting RISC-V executable
get-backprop-riscv: ${OUTPUT_FILE}

objdump:
	@${VENTUS_INSTALL_PREFIX}/bin/llvm-objdump -d --mattr=+v,+zfinx $(OUTPUT_FILE) > $(OUTPUT_FILE).log 2>&1
	@echo ">>> Disassembly written to $(OUTPUT_FILE).log"


# Target for running RISC-V executable
# Note: Before executing run-backprop-riscv, follow these steps:
# 1. Replace `ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/test.cpp` with the `test.cpp` file provided in the current directory.
# 2. Navigate to the driver directory and complete the build process as described in the README file.
pass-to-driver:
	cp ${OUTPUT_FILE} ../_driver/build/${OUTPUT_FILE} 
	cp test.cpp ../_driver/test.cpp

# Clean up generated files
clean:
	rm -f ${LLVM_DIALECT_FILE} ${LL_FILE} ${OBJ_FILE} ${OUTPUT_FILE} ${LLVM_DIALECT_FROM_GPU_FILE} backprop.riscv.log

.PHONY: get-backprop-riscv run-backprop-riscv clean
