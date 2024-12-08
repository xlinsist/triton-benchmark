LLVM_BUILD := /root/ventus/llvm-project/build
MLIR_TRANSLATE := ${LLVM_BUILD}/bin/mlir-translate
TRANSLATE := ./translate/build/translate

make-translate: 
	mkdir -p ./translate/build
	cmake ./translate -B ./translate/build
	cmake --build ./translate/build

backprop_manual.ll: backprop_manual.mlir
	@${MLIR_TRANSLATE} --mlir-to-llvmir -o $@ $<

backprop_official_import_llvm.mlir: backprop_official.ll
	@${MLIR_TRANSLATE} --import-llvm -o $@ $<

backprop_official_import_llvm_to_llvmir.ll: backprop_official_import_llvm.mlir
	@${MLIR_TRANSLATE} --mlir-to-llvmir -o $@ $<

backprop_custom_translate.ll: backprop_official_import_llvm.mlir 
	@${TRANSLATE} $< $@ 

#################### Running backprop_*.ll based on ventus toolchains ####################

# Change it to your local path.
# VENTUS_INSTALL_PREFIX := /root/ventus/llvm-project/install
VENTUS_SPIKE_BUILD := ./driver/build
SPIKE_SRC_DIR := /root/ventus/ventus-gpgpu-isa-simulator/
SPIKE_TARGET_DIR := /root/ventus/ventus-gpgpu-isa-simulator/spike_main

make-spike-test:
	mkdir -p ./driver/build
	cmake ./driver -B ./driver/build -DSPIKE_SRC_DIR=${SPIKE_SRC_DIR} -DSPIKE_TARGET_DIR=${SPIKE_TARGET_DIR}
	cmake --build ./driver/build

# All backprop_official.ll, backprop_manual.ll and backprop_official_import_llvm_to_llvmir.ll can be renamed to backprop.ll.
get-backprop-riscv:
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu backprop.ll -o backprop.s
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj backprop.ll -o backprop.o
	${VENTUS_INSTALL_PREFIX}/bin/ld.lld -o backprop.riscv -T ${VENTUS_INSTALL_PREFIX}/../utils/ldscripts/ventus/elf32lriscv.ld backprop.o ${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o -L${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init bpnn_layerforward_ocl --init bpnn_adjust_weights_ocl

run-backprop-riscv:
	cp backprop.riscv ${VENTUS_SPIKE_BUILD}
	${VENTUS_SPIKE_BUILD}/spike_test

clean:
	-rm backprop.s backprop.o backprop.riscv backprop.riscv.log
	-rm -r ./translate/build
	-rm -r ./driver/build
