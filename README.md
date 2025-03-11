# triton-benchmark

This project focuses on evaluating the tuning capabilities of **triton-cpu** for optimizing AI kernels on multicore CPUs. It compares triton-cpu's runtime auto-tuning with both compiler-based auto-tuning (e.g., GCC, Clang) and other runtime tuning frameworks (e.g., TVM, Hidet).

The [benchmarks](./benchmarks/README.md) directory analyzes triton-cpu's runtime auto-tuning on multicore CPUs, comparing it with compiler-based auto-tuning to **assess the impact of different tuning parameters**.

The [cases](./cases/README.md) directory **evaluates both the performance and tuning time** of AI kernels optimized using different tuning frameworks on multi-core CPUs.

Refer to README in the directories above for environmental setup and more other details.
