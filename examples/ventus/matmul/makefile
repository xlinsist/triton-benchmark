# The commit id of triton used here is `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`.
# The corresponding commit id of llvm-project is `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`.
MLIR_TRANSLATE := ${LLVM_BUILD_DIR}/bin/mlir-translate
MLIR_OPT := ${LLVM_BUILD_DIR}/bin/mlir-opt

# Change it to your local path.
VENTUS_SPIKE_BUILD := ~/myProject/ventus-toolchain/ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/build
LLC := ${VENTUS_INSTALL_PREFIX}/bin/llc
LD := ${VENTUS_INSTALL_PREFIX}/bin/ld.lld

# Source and target files
FILENAME=matmul
MLIR_FILE=${FILENAME}.mlir
LLVM_DIALECT_FILE=${FILENAME}_llvm_dialect.mlir
LL_FILE=${FILENAME}.ll
OBJ_FILE=${FILENAME}.o
OUTPUT_FILE=${FILENAME}.riscv


${LLVM_DIALECT_FILE}: ${MLIR_FILE}
	@${MLIR_OPT} $< \
	--mlir-print-ir-after-all \
	--pass-pipeline="builtin.module( \
	convert-func-to-llvm{use-bare-ptr-memref-call-conv=true}, \
    memref-expand, \
    normalize-memrefs, \
    expand-strided-metadata, \
    canonicalize, \
    convert-vector-to-scf, \
    convert-scf-to-cf, \
    canonicalize, \
    arith-expand, \
    convert-arith-to-llvm, \
    convert-vector-to-llvm, \
    convert-cf-to-llvm, \
    finalize-memref-to-llvm, \
	lower-affine, \
	convert-arith-to-llvm, \
	reconcile-unrealized-casts, \
	canonicalize \
    )" \
	-o $@ > debug.log 2>&1
	@echo ">>> .mlir --> mlir-dialect"

#TODO: builtin.unrealized_conversion_cast bugs need fix

# Rules for generating LLVM IR file  
# Note: use sed to add 'ventus_kernel'
${LL_FILE}: ${LLVM_DIALECT_FILE}
	@${MLIR_TRANSLATE} -mlir-to-llvmir $< -o $@
	@sed -i 's/define void @${FILENAME}/define ventus_kernel void @${FILENAME}/' $@
	@echo ">>> mlir-dialect --> .ll"

# Rules for generating object file
${OBJ_FILE}: ${LL_FILE}
	@${LLC} -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj $< -o $@
	@echo ">>> .ll --> .obj"

# Rules for generating RISC-V executable
${OUTPUT_FILE}: ${OBJ_FILE}
	@${LD} -o $@ -T ${VENTUS_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld $< ${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o -L ${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init ${FILENAME}
	@echo ">>> .obj --> .riscv"

# Target for getting RISC-V executable
get-${FILENAME}-riscv: ${OUTPUT_FILE}

# Dump log from RISC-V executable
objdump:
	@${VENTUS_INSTALL_PREFIX}/bin/llvm-objdump -d --mattr=+v,+zfinx $(OUTPUT_FILE) > $(OUTPUT_FILE).log 2>&1
	@echo ">>> Disassembly written to $(OUTPUT_FILE).log"

# Target for running RISC-V executable
pass-to-driver:
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make
	@find ${SPIKE_SRC_DIR}/gpgpu-testcase/driver/build/ -type f -name "*.riscv" -delete
	@cp test.cpp ${SPIKE_SRC_DIR}/gpgpu-testcase/driver/test.cpp
	@cp ${OUTPUT_FILE} ${SPIKE_SRC_DIR}/gpgpu-testcase/driver/build/${OUTPUT_FILE}
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make clean

# Run RISC-V executable on the driver
run-${FILENAME}-riscv:
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make all
	@cd ${SPIKE_SRC_DIR}/gpgpu-testcase/driver && make run

# Clean up generated files
clean:
	rm -f ${LLVM_DIALECT_FILE} ${LL_FILE} ${OBJ_FILE} ${OUTPUT_FILE} ${LLVM_DIALECT_FROM_GPU_FILE} ${FILENAME}.riscv.log

.PHONY: get-${FILENAME}-riscv run-${FILENAME}-riscv clean
