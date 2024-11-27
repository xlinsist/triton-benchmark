# triton-benchmark

## examples的文件生成
以vectoradd为例，首先，在triton-cpu目录下，git apply根目录下的triton-cpu-0001-RISCV.patch（这个patch涉及的重要改动之一是将triton中间文件的生成路径从.triton/cache里改到里特定的位置）。
然后，指定KERNEL_AUX_FILE_DIR为当前路径，运行vectoradd示例程序：
```
$ export KERNEL_AUX_FILE_DIR=./vectoradd
$ TRITON_CPU_BACKEND=1 python ../triton-cpu/python/tutorials/01-vector-add.py
```
最后将Triton编译器里的中间表示单独拎出来做手动下降（而不是用Triton编译器后端自动下降），得到LLVM IR dialect：
```
$ make tttcir-lowering
```
