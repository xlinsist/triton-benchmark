#!/bin/bash
# Refer to https://github.com/buddy-compiler/buddy-mlir to build Buddy Compiler from source with Nvidia GPU configured in LLVM
# Commit id of buddy-mlir: cf21db1697
# Commit id of llvm bumped for buddy-mlir: 6c59f0e1b
BUDDY_OPT := /home/zhouxulin/intern/buddy-mlir/build/bin/buddy-opt
MLIR_OPT := /home/zhouxulin/intern/buddy-mlir/llvm/build/bin/mlir-opt

# Use official MLIR to convert linalg dialect(`linalg.matmul` in matmul.mlir) to gpu dialect(`gpu.barrier` and `gpu.thread_id` in 2-log-before-hoisting.mlir)
# log number 1 is genreated by manually remove some parts in the lowering pipeline
2-log-before-hoisting.mlir: matmul.mlir
	@${MLIR_OPT} $< \
		-transform-preload-library="transform-library-paths=transform-mlir.mlir" \
		-transform-interpreter="entry-point=codegen" \
		-o $@
	@${MLIR_OPT} $@ --print-op-stats > /dev/null

# Use custom transform dialects from Buddy Compiler to convert linalg dialect to nvgpu dialect
# logs from number 3 to 6 are genreated by manually remove some parts in the lowering pipeline
7-log-after-nvgpumma.mlir: matmul.mlir
	@${BUDDY_OPT} $< \
		-transform-preload-library="transform-library-paths=transform-buddy.mlir" \
		-transform-interpreter="entry-point=codegen" \
		-o $@

# The passes in mlir-opt are commonly used for targeting CPUs, while others are customized in Buddy Compiler
matmul-cubin.mlir: 7-log-after-nvgpumma.mlir
	@${BUDDY_OPT} $< --pass-pipeline='builtin.module(func.func(nvgpu-optimize-shared-memory))' | \
	${MLIR_OPT} -arith-expand -eliminate-empty-tensors -empty-tensor-to-alloc-tensor -linalg-bufferize -convert-linalg-to-affine-loops -affine-loop-fusion -affine-parallelize -lower-affine -canonicalize -func-bufferize -arith-bufferize -tensor-bufferize -buffer-deallocation -finalizing-bufferize -canonicalize | \
	${BUDDY_OPT} -gpu-launch-sink-index-computations -canonicalize -legalize-shmem-outlining -canonicalize | \
	${BUDDY_OPT} -convert-memcpy-to-gpu -gpu-async-region -canonicalize | \
	${MLIR_OPT} -convert-scf-to-cf -memref-expand -finalize-memref-to-llvm -convert-arith-to-llvm --convert-vector-to-llvm -convert-gpu-to-nvvm='has-redux=1' | \
	${MLIR_OPT} -llvm-request-c-wrappers -canonicalize -cse -sccp | \
	${MLIR_OPT} --test-lower-to-nvvm="cubin-chip=sm_80 cubin-features=+ptx71 cubin-format=fatbin" -o $@
