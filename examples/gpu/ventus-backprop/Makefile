# Change it to your local path.
LLVM_BUILD := /root/ventus/llvm-project/build

MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
DIFF_TOOL := vimdiff

backprop_official_import_llvm.mlir: backprop_official.ll
	@${MLIR_TRANSLATE} --import-llvm -o $@ $<

backprop_official_import_llvm_to_llvmir.ll: backprop_official_import_llvm.mlir
	@${MLIR_TRANSLATE} --mlir-to-llvmir -o $@ $<

%.s: %.ll 
	${LLVM_BUILD}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu $< -o $@

view-diff: backprop_custom_translate.s backprop_official.s
	${DIFF_TOOL} $^	

#################### Running backprop_*.ll based on ventus toolchains ####################

# Change it to your local path.
VENTUS_INSTALL_PREFIX := /root/ventus/llvm-project/install
VENTUS_SPIKE_BUILD := /root/ventus/ventus-gpgpu-isa-simulator/gpgpu-testcase/driver/build

# All backprop_official.ll, backprop_manual.ll and backprop_official_import_llvm_to_llvmir.ll can be renamed to backprop.ll.
get-backprop-riscv:
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu backprop.ll -o backprop.s
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj backprop.ll -o backprop.o
	${VENTUS_INSTALL_PREFIX}/bin/ld.lld -o vecadd.riscv -T ${VENTUS_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld backprop.o ${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o -L${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init bpnn_layerforward_ocl --init bpnn_adjust_weights_ocl

run-backprop-riscv:
	cp vecadd.riscv ${VENTUS_SPIKE_BUILD}
	${VENTUS_SPIKE_BUILD}/spike_test

clean:
	-rm *.s backprop.o vecadd.riscv vecadd.riscv.log
