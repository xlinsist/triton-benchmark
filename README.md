# triton-benchmark

## examples使用示例
以vector-add为例，将Triton编译器里的中间表示单独拎出来做手动下降（而不是用Triton编译器后端自动下降），最终得到LLVM IR dialect的执行步骤如下：
```
$ cd examples/vectoradd
$ make tttcir-lowering
```
更多示例见benchmarks目录下的[README](./examples/README.md)。

## benchmarks使用示例
 7个AI算子分别在1核、4核和8核，采用gcc、clang和triton，在RISC-V CPU（SpacemiT Muse Pi）上的执行结果如下，执行步骤见benchmarks目录下的[README](./benchmarks/README.md)。

```
##### correlation kernel performance #####
shape (OUT_CHANNELxIN_CHANNELxHEIGHTxWIDTHxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
5x58x112x88x10	0.406807	0.550575	0.185582	0.0896354	0.131778	0.0554982	0.049427	0.0692719	0.0323904



##### dropout kernel performance #####
shape (NxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
1048576x10	0.437414	44.4074	16.5371	0.116678	11.179	4.19115	0.0652238	5.60955	2.13063



##### layernorm kernel performance #####
shape (NxDxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
1151x8192x10	3.99499	5.10841	4.87809	1.1298	1.37735	1.63461	1.03388	0.985506	1.00223



##### matmul kernel performance #####
shape (MxNxKxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
128x128x64x10	0.0529591	0.063293	2.19012	0.017613	0.0199949	0.564048	0.0123523	0.0135753	0.286434



##### resize kernel performance #####
shape (HxWxCxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
512x512x3x10	0.802106	1.19739	1.42896	0.205363	0.304806	0.362561	0.107914	0.157187	0.186983



##### rope kernel performance #####
shape (SEQ_LENxBATCH_NUMxHEAD_NUMxHEAD_DIMxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
512x16x8x1024x10	6.71872	7.74758	11.4048	2.25791	2.43972	3.19468	1.86013	1.97924	2.25463



##### softmax_kernel kernel performance #####
shape (RxCxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
1823x781x10	0.841515	0.820086	0.904563	0.221429	0.212233	0.232222	0.116075	0.112719	0.122978



##### warp kernel performance #####
shape (HxWxCxRUN_COUNT)	gcc_T1	clang_T1	triton_T1	gcc_T4	clang_T4	triton_T4	gcc_T8	clang_T8	triton_T8
1024x1024x3x10	0.620494	1.33427	1.22298	0.161322	0.339647	0.311901	0.0858445	0.174764	0.161152
```