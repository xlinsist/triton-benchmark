# The commit id of triton used here is `83cf4362bd87c74bf57e79a7e213b4301fa3f25c`.
# The corresponding commit id of llvm-project is `a4c3683b665c6ac875b4821f5c6a881fdf5fef70`.
# TRITON_BUILD := ../../../triton/python/build/cmake.linux-x86_64-cpython-3.10
LLVM_BUILD := ../../../llvm-project/build
# TRITON_OPT := ${TRITON_BUILD}/bin/triton-opt
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate

# FIXME: In general, calling convention `ventus.kernel` should be manually added to "vecadd_manual.ll" after generation.
# Here we didn't add them, but both get-vecadd-riscv and run-vecadd-riscv seem to work fine. We need to know why
vecadd_manual.ll: vecadd_manual.mlir
	@${MLIR_TRANSLATE} --mlir-to-llvmir -o $@ $<

# `dso_local` and `ventus_kernel` are manually removed in "vecadd_official.ll"
vecadd_official_import_llvm.mlir: vecadd_official.ll
	@${MLIR_TRANSLATE} --import-llvm -o $@ $<

vecadd_official_import_llvm_to_llvmir.ll: vecadd_official_import_llvm.mlir
	@${MLIR_TRANSLATE} --mlir-to-llvmir -o $@ $<

#################### Running vecadd_*.ll based on ventus toolchains ####################

# Change it to your local path.
VENTUS_INSTALL_PREFIX := /root/ventus/llvm-project/install
VENTUS_SPIKE_BUILD := /root/ventus/ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/build

# All vecadd_official.ll, vecadd_manual.ll and vecadd_official_import_llvm_to_llvmir.ll can be renamed to vecadd.ll.
get-vecadd-riscv:
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu vecadd.ll -o vecadd.s
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj vecadd.ll -o vecadd.o
	${VENTUS_INSTALL_PREFIX}/bin/ld.lld -o vecadd.riscv -T ${VENTUS_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld vecadd.o ${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o -L${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init vectorAdd

run-vecadd-riscv:
	cp vecadd.riscv ${VENTUS_SPIKE_BUILD}
	${VENTUS_SPIKE_BUILD}/spike_test

clean:
	rm vecadd.s vecadd.o vecadd.riscv
