	.text
	.file	"LLVMDialectModule"
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0                          # -- Begin function gemv_kernel
.LCPI0_0:
	.zero	4
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.long	8                               # 0x8
	.long	9                               # 0x9
	.long	10                              # 0xa
	.long	11                              # 0xb
	.long	12                              # 0xc
	.long	13                              # 0xd
	.long	14                              # 0xe
	.long	15                              # 0xf
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5, 0x0
.LCPI0_1:
	.long	0                               # 0x0
	.long	2                               # 0x2
	.long	4                               # 0x4
	.long	6                               # 0x6
	.long	8                               # 0x8
	.long	10                              # 0xa
	.long	12                              # 0xc
	.long	14                              # 0xe
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI0_2:
	.short	0                               # 0x0
	.short	65535                           # 0xffff
.LCPI0_3:
	.byte	0                               # 0x0
	.byte	2                               # 0x2
	.byte	4                               # 0x4
	.byte	6                               # 0x6
	.text
	.globl	gemv_kernel
	.p2align	4
	.type	gemv_kernel,@function
gemv_kernel:                            # @gemv_kernel
.Lfunc_begin0:
	.file	1 "/root/triton/triton-cpu/./python/tutorials" "matrix-vector-multiplication-bf16.py"
	.loc	1 19 0                          # matrix-vector-multiplication-bf16.py:19:0
	.cfi_sections .debug_frame
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$2280, %rsp                     # imm = 0x8E8
	.cfi_def_cfa_offset 2336
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	2336(%rsp), %r10d
.Ltmp0:
	.loc	1 30 19 prologue_end            # matrix-vector-multiplication-bf16.py:30:19
	shll	$4, %r10d
	.loc	1 37 25                         # matrix-vector-multiplication-bf16.py:37:25
	testl	%r8d, %r8d
	jle	.LBB0_1
# %bb.2:                                # %.lr.ph.preheader
	.loc	1 0 25 is_stmt 0                # matrix-vector-multiplication-bf16.py:0:25
	movq	%rdi, -72(%rsp)                 # 8-byte Spill
	.loc	1 33 13 is_stmt 1               # matrix-vector-multiplication-bf16.py:33:13
	vmovq	%rsi, %xmm0
	.loc	1 30 34                         # matrix-vector-multiplication-bf16.py:30:34
	vpbroadcastd	%r10d, %zmm1
	vpord	.LCPI0_0(%rip), %zmm1, %zmm1
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vextracti32x4	$3, %zmm1, %xmm3
	vpextrd	$3, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13 is_stmt 0               # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm2
	.loc	1 34 12 is_stmt 1               # matrix-vector-multiplication-bf16.py:34:12
	vpaddd	%xmm2, %xmm2, %xmm2
	vpmovsxdq	%xmm2, %xmm2
	vpaddq	%xmm2, %xmm0, %xmm2
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$2, %xmm3, %eax
	.loc	1 34 12                         # matrix-vector-multiplication-bf16.py:34:12
	vmovq	%xmm2, -128(%rsp)               # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	imull	%r9d, %eax
	.loc	1 33 13 is_stmt 0               # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm2
	vpaddd	%xmm2, %xmm2, %xmm4
	vpmovsxbd	.LCPI0_3(%rip), %xmm2   # xmm2 = [0,2,4,6]
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, -104(%rsp)               # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$1, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm4
	vpaddd	%xmm4, %xmm4, %xmm4
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, 24(%rsp)                 # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vmovd	%xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm3
	vpaddd	%xmm3, %xmm3, %xmm3
	vpaddd	%xmm2, %xmm3, %xmm3
	vpmovsxdq	%xmm3, %xmm3
	vpaddq	%xmm3, %xmm0, %xmm3
	vmovq	%xmm3, 16(%rsp)                 # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vextracti32x4	$2, %zmm1, %xmm3
	vpextrd	$3, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm4
	vpaddd	%xmm4, %xmm4, %xmm4
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, 8(%rsp)                  # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$2, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm4
	vpaddd	%xmm4, %xmm4, %xmm4
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, (%rsp)                   # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$1, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm4
	vpaddd	%xmm4, %xmm4, %xmm4
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, -8(%rsp)                 # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vmovd	%xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm3
	vpaddd	%xmm3, %xmm3, %xmm3
	vpaddd	%xmm2, %xmm3, %xmm3
	vpmovsxdq	%xmm3, %xmm3
	vpaddq	%xmm3, %xmm0, %xmm3
	vmovq	%xmm3, -16(%rsp)                # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vextracti128	$1, %ymm1, %xmm3
	vpextrd	$3, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm4
	vpaddd	%xmm4, %xmm4, %xmm4
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, -24(%rsp)                # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$2, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm4
	vpaddd	%xmm4, %xmm4, %xmm4
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, -32(%rsp)                # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$1, %xmm3, %eax
	imull	%r9d, %eax
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%eax, %xmm4
	vpaddd	%xmm4, %xmm4, %xmm4
	vpaddd	%xmm2, %xmm4, %xmm4
	vpmovsxdq	%xmm4, %xmm4
	vpaddq	%xmm4, %xmm0, %xmm4
	vmovq	%xmm4, -40(%rsp)                # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vmovd	%xmm3, %ecx
	imull	%r9d, %ecx
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%ecx, %xmm3
	vpaddd	%xmm3, %xmm3, %xmm3
	vpaddd	%xmm2, %xmm3, %xmm3
	vpmovsxdq	%xmm3, %xmm3
	vpaddq	%xmm3, %xmm0, %xmm3
	vmovq	%xmm3, -48(%rsp)                # 8-byte Folded Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$3, %xmm1, %ecx
	imull	%r9d, %ecx
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%ecx, %xmm3
	vpaddd	%xmm3, %xmm3, %xmm3
	vpaddd	%xmm2, %xmm3, %xmm3
	vpmovsxdq	%xmm3, %xmm3
	vpaddq	%xmm3, %xmm0, %xmm3
	vmovq	%xmm3, -56(%rsp)                # 8-byte Folded Spill
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$2, %xmm1, %edx
	imull	%r9d, %edx
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%edx, %xmm3
	vpaddd	%xmm3, %xmm3, %xmm3
	vpaddd	%xmm2, %xmm3, %xmm3
	vpmovsxdq	%xmm3, %xmm3
	vpaddq	%xmm3, %xmm0, %xmm3
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	vpextrd	$1, %xmm1, %edx
	imull	%r9d, %edx
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%edx, %xmm1
	movl	%r8d, -88(%rsp)                 # 4-byte Spill
	vmovq	%xmm3, -80(%rsp)                # 8-byte Folded Spill
	vpaddd	%xmm1, %xmm1, %xmm1
	vpaddd	%xmm2, %xmm1, %xmm1
	vpmovsxdq	%xmm1, %xmm1
	vpaddq	%xmm1, %xmm0, %xmm1
	movl	%r10d, -92(%rsp)                # 4-byte Spill
	.loc	1 33 39                         # matrix-vector-multiplication-bf16.py:33:39
	imull	%r10d, %r9d
	.loc	1 33 13                         # matrix-vector-multiplication-bf16.py:33:13
	vmovd	%r9d, %xmm3
	vmovq	%xmm1, -64(%rsp)                # 8-byte Folded Spill
	vpaddd	%xmm3, %xmm3, %xmm1
	vpaddd	%xmm2, %xmm1, %xmm1
	vpmovsxdq	%xmm1, %xmm1
	vpaddq	%xmm1, %xmm0, %xmm0
	vpxor	%xmm2, %xmm2, %xmm2
	vbroadcastss	.LCPI0_2(%rip), %zmm1   # zmm1 = [0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535,0,65535]
	vmovq	%xmm0, -112(%rsp)               # 8-byte Folded Spill
	xorl	%edx, %edx
	xorl	%eax, %eax
	movq	-56(%rsp), %rdi                 # 8-byte Reload
	movq	-48(%rsp), %r8                  # 8-byte Reload
	movq	-40(%rsp), %r9                  # 8-byte Reload
	movq	-32(%rsp), %r10                 # 8-byte Reload
	movq	-24(%rsp), %r11                 # 8-byte Reload
	movq	-16(%rsp), %rbx                 # 8-byte Reload
	movq	-8(%rsp), %r14                  # 8-byte Reload
	movq	(%rsp), %r15                    # 8-byte Reload
	movq	8(%rsp), %r12                   # 8-byte Reload
	movq	16(%rsp), %r13                  # 8-byte Reload
	movq	24(%rsp), %rbp                  # 8-byte Reload
	.loc	1 0 13                          # :0:13
.Ltmp1:
	.p2align	4
.LBB0_3:                                # %.lr.ph
                                        # =>This Inner Loop Header: Depth=1
	movl	%eax, -84(%rsp)                 # 4-byte Spill
	vmovdqu64	%zmm2, 2208(%rsp)       # 64-byte Spill
	movq	-112(%rsp), %rax                # 8-byte Reload
	.loc	1 40 26 is_stmt 1               # matrix-vector-multiplication-bf16.py:40:26
	vpmovzxwd	96(%rax,%rdx), %zmm2    # zmm2 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%rax,%rdx), %zmm0    # zmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vmovdqu64	%zmm0, 32(%rsp)         # 64-byte Spill
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	vpmovzxwd	96(%rcx,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%rcx,%rdx), %zmm16   # zmm16 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	movq	-80(%rsp), %rax                 # 8-byte Reload
	vpmovzxwd	96(%rax,%rdx), %zmm4    # zmm4 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%rax,%rdx), %zmm19   # zmm19 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%rdi,%rdx), %zmm5    # zmm5 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%rdi,%rdx), %zmm21   # zmm21 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r8,%rdx), %zmm6     # zmm6 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r8,%rdx), %zmm22    # zmm22 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r9,%rdx), %zmm7     # zmm7 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r9,%rdx), %zmm23    # zmm23 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r10,%rdx), %zmm8    # zmm8 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r10,%rdx), %zmm24   # zmm24 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r11,%rdx), %zmm9    # zmm9 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r11,%rdx), %zmm25   # zmm25 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%rbx,%rdx), %zmm10   # zmm10 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%rbx,%rdx), %zmm26   # zmm26 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r14,%rdx), %zmm11   # zmm11 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r14,%rdx), %zmm27   # zmm27 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r15,%rdx), %zmm12   # zmm12 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r15,%rdx), %zmm28   # zmm28 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r12,%rdx), %zmm13   # zmm13 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r12,%rdx), %zmm29   # zmm29 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%r13,%rdx), %zmm15   # zmm15 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%r13,%rdx), %zmm30   # zmm30 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	96(%rbp,%rdx), %zmm17   # zmm17 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%rbp,%rdx), %zmm31   # zmm31 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	movq	-104(%rsp), %rax                # 8-byte Reload
	vpmovzxwd	96(%rax,%rdx), %zmm18   # zmm18 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpmovzxwd	32(%rax,%rdx), %zmm0    # zmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	movq	-128(%rsp), %rax                # 8-byte Reload
	vpmovzxwd	96(%rax,%rdx), %zmm20   # zmm20 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	movq	%rax, -128(%rsp)                # 8-byte Spill
	vpslld	$16, %zmm2, %zmm2
	vpslld	$16, %zmm3, %zmm3
	vpslld	$16, %zmm4, %zmm4
	vpslld	$16, %zmm5, %zmm5
	vpslld	$16, %zmm6, %zmm6
	vpslld	$16, %zmm7, %zmm7
	vpslld	$16, %zmm8, %zmm8
	vpslld	$16, %zmm9, %zmm9
	vpslld	$16, %zmm10, %zmm10
	vpslld	$16, %zmm11, %zmm11
	vpslld	$16, %zmm12, %zmm12
	vpslld	$16, %zmm13, %zmm13
	vpslld	$16, %zmm15, %zmm15
	vpslld	$16, %zmm17, %zmm17
	vpslld	$16, %zmm18, %zmm18
	vpslld	$16, %zmm20, %zmm20
	movq	-120(%rsp), %rsi                # 8-byte Reload
	vpmovzxwd	96(%rsi,%rdx), %zmm14   # zmm14 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm14, %zmm14
	vmulps	%zmm14, %zmm2, %zmm2
	vmovups	%zmm2, 1056(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm3, %zmm2
	vmovups	%zmm2, 1184(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm4, %zmm2
	vmovups	%zmm2, 1248(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm5, %zmm2
	vmovups	%zmm2, 1376(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm6, %zmm2
	vmovups	%zmm2, 1440(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm7, %zmm2
	vmovups	%zmm2, 1504(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm8, %zmm2
	vmovups	%zmm2, 1568(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm9, %zmm2
	vmovups	%zmm2, 1632(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm10, %zmm2
	vmovups	%zmm2, 1696(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm11, %zmm2
	vmovups	%zmm2, 1760(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm12, %zmm2
	vmovups	%zmm2, 1824(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm13, %zmm2
	vmovups	%zmm2, 1888(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm15, %zmm2
	vmovups	%zmm2, 1952(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm17, %zmm2
	vmovups	%zmm2, 2016(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm18, %zmm2
	vmovups	%zmm2, 2080(%rsp)               # 64-byte Spill
	vmulps	%zmm14, %zmm20, %zmm2
	vmovups	%zmm2, 2144(%rsp)               # 64-byte Spill
	vpmovzxwd	32(%rax,%rdx), %zmm2    # zmm2 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, 32(%rsp), %zmm3            # 64-byte Folded Reload
	vpslld	$16, %zmm16, %zmm4
	vpslld	$16, %zmm19, %zmm5
	vpslld	$16, %zmm21, %zmm6
	vpslld	$16, %zmm22, %zmm7
	vpslld	$16, %zmm23, %zmm8
	vpslld	$16, %zmm24, %zmm9
	vpslld	$16, %zmm25, %zmm10
	vpslld	$16, %zmm26, %zmm12
	vpslld	$16, %zmm27, %zmm13
	vpslld	$16, %zmm28, %zmm14
	vpslld	$16, %zmm29, %zmm15
	vpslld	$16, %zmm30, %zmm16
	vpslld	$16, %zmm31, %zmm17
	vpslld	$16, %zmm0, %zmm0
	vpslld	$16, %zmm2, %zmm2
	vpmovzxwd	32(%rsi,%rdx), %zmm11   # zmm11 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm11, %zmm19
	vmulps	%zmm19, %zmm3, %zmm18
	vmulps	%zmm19, %zmm4, %zmm11
	vmulps	%zmm19, %zmm5, %zmm23
	vmulps	%zmm19, %zmm6, %zmm3
	vmovups	%zmm3, 160(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm7, %zmm3
	vmovups	%zmm3, 288(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm8, %zmm3
	vmovups	%zmm3, 416(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm9, %zmm3
	vmovups	%zmm3, 544(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm10, %zmm3
	vmovups	%zmm3, 672(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm12, %zmm3
	vmovups	%zmm3, 736(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm13, %zmm3
	vmovups	%zmm3, 800(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm14, %zmm3
	vmovups	%zmm3, 864(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm15, %zmm3
	vmovups	%zmm3, 928(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm16, %zmm3
	vmovups	%zmm3, 992(%rsp)                # 64-byte Spill
	vmulps	%zmm19, %zmm17, %zmm3
	vmovups	%zmm3, 1120(%rsp)               # 64-byte Spill
	vmulps	%zmm19, %zmm0, %zmm0
	vmovups	%zmm0, 1312(%rsp)               # 64-byte Spill
	vmulps	%zmm19, %zmm2, %zmm0
	vmovups	%zmm0, 32(%rsp)                 # 64-byte Spill
	movq	-112(%rsp), %rax                # 8-byte Reload
	vpmovzxwd	64(%rax,%rdx), %zmm0    # zmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm0, %zmm4
	vpmovzxwd	64(%rcx,%rdx), %zmm2    # zmm2 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm2, %zmm7
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	vpmovzxwd	64(%rsi,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm5
	vpmovzxwd	64(%rdi,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm6
	vpmovzxwd	64(%r8,%rdx), %zmm3     # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm9
	vpmovzxwd	64(%r9,%rdx), %zmm3     # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm10
	vpmovzxwd	64(%r10,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm12
	vpmovzxwd	64(%r11,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm14
	vpmovzxwd	64(%rbx,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm16
	vpmovzxwd	64(%r14,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm19
	vpmovzxwd	64(%r15,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm22
	vpmovzxwd	64(%r12,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm24
	vpmovzxwd	64(%r13,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm25
	vpmovzxwd	64(%rbp,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm27
	movq	-104(%rsp), %rax                # 8-byte Reload
	vpmovzxwd	64(%rax,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm29
	movq	-128(%rsp), %rax                # 8-byte Reload
	vpmovzxwd	64(%rax,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm0
	movq	-120(%rsp), %rax                # 8-byte Reload
	vpmovzxwd	64(%rax,%rdx), %zmm3    # zmm3 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm3, %zmm2
	vmulps	%zmm2, %zmm4, %zmm3
	vmulps	%zmm2, %zmm7, %zmm4
	vmulps	%zmm2, %zmm5, %zmm7
	vmulps	%zmm2, %zmm6, %zmm8
	vmulps	%zmm2, %zmm9, %zmm13
	vmulps	%zmm2, %zmm10, %zmm9
	vmulps	%zmm2, %zmm12, %zmm15
	vmulps	%zmm2, %zmm14, %zmm17
	vmulps	%zmm2, %zmm16, %zmm20
	vmulps	%zmm2, %zmm19, %zmm21
	vmulps	%zmm2, %zmm22, %zmm22
	vmulps	%zmm2, %zmm24, %zmm5
	vmovups	%zmm5, 96(%rsp)                 # 64-byte Spill
	vmulps	%zmm2, %zmm25, %zmm5
	vmovups	%zmm5, 224(%rsp)                # 64-byte Spill
	vmulps	%zmm2, %zmm27, %zmm5
	vmovups	%zmm5, 352(%rsp)                # 64-byte Spill
	vmulps	%zmm2, %zmm29, %zmm5
	vmovups	%zmm5, 480(%rsp)                # 64-byte Spill
	vmulps	%zmm2, %zmm0, %zmm0
	vmovups	%zmm0, 608(%rsp)                # 64-byte Spill
	movq	-112(%rsp), %rax                # 8-byte Reload
	vpmovzxwd	(%rax,%rdx), %zmm0      # zmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm0, %zmm0
	vpmovzxwd	(%rcx,%rdx), %zmm2      # zmm2 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm2, %zmm2
	vpmovzxwd	(%rsi,%rdx), %zmm5      # zmm5 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm5, %zmm5
	vpmovzxwd	(%rdi,%rdx), %zmm6      # zmm6 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm6, %zmm6
	vpmovzxwd	(%r8,%rdx), %zmm10      # zmm10 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm10, %zmm10
	vpmovzxwd	(%r9,%rdx), %zmm12      # zmm12 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm12, %zmm12
	vpmovzxwd	(%r10,%rdx), %zmm14     # zmm14 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm14, %zmm14
	vpmovzxwd	(%r11,%rdx), %zmm16     # zmm16 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm16, %zmm16
	vpmovzxwd	(%rbx,%rdx), %zmm19     # zmm19 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm19, %zmm19
	vpmovzxwd	(%r14,%rdx), %zmm27     # zmm27 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	movl	-84(%rsp), %eax                 # 4-byte Reload
	vpslld	$16, %zmm27, %zmm27
	vpmovzxwd	(%r15,%rdx), %zmm29     # zmm29 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm29, %zmm29
	vpmovzxwd	(%r12,%rdx), %zmm28     # zmm28 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm28, %zmm28
	vpmovzxwd	(%r13,%rdx), %zmm30     # zmm30 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm30, %zmm30
	vpmovzxwd	(%rbp,%rdx), %zmm31     # zmm31 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm31, %zmm31
	movq	-104(%rsp), %rcx                # 8-byte Reload
	vpmovzxwd	(%rcx,%rdx), %zmm25     # zmm25 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm25, %zmm25
	movq	-128(%rsp), %rcx                # 8-byte Reload
	vpmovzxwd	(%rcx,%rdx), %zmm26     # zmm26 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm26, %zmm26
	movq	-120(%rsp), %rcx                # 8-byte Reload
	vpmovzxwd	(%rcx,%rdx), %zmm24     # zmm24 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero,mem[8],zero,mem[9],zero,mem[10],zero,mem[11],zero,mem[12],zero,mem[13],zero,mem[14],zero,mem[15],zero
	vpslld	$16, %zmm24, %zmm24
	vmulps	%zmm24, %zmm0, %zmm0
	vmulps	%zmm24, %zmm2, %zmm2
	vmulps	%zmm24, %zmm5, %zmm5
	vmulps	%zmm24, %zmm6, %zmm6
	vmulps	%zmm24, %zmm10, %zmm10
	vmulps	%zmm24, %zmm12, %zmm12
	vmulps	%zmm24, %zmm14, %zmm14
	vmulps	%zmm24, %zmm16, %zmm16
	vmulps	%zmm24, %zmm19, %zmm19
	vmulps	%zmm24, %zmm27, %zmm27
	vmulps	%zmm24, %zmm29, %zmm29
	vmulps	%zmm24, %zmm28, %zmm28
	vmulps	%zmm24, %zmm30, %zmm30
	vmulps	%zmm24, %zmm31, %zmm31
	vmulps	%zmm24, %zmm25, %zmm25
	vmulps	%zmm24, %zmm26, %zmm24
.Ltmp2:
	.file	2 "/root/triton/triton-cpu/python/triton/language" "standard.py"
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm0, %zmm0
	vandps	%zmm1, %zmm3, %zmm3
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm0, %zmm3, %zmm0
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm18, %zmm3
	vandps	1056(%rsp), %zmm1, %zmm18       # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm3, %zmm18, %zmm3
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm2, %zmm2
	vandps	%zmm1, %zmm4, %zmm4
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm4, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm11, %zmm4
	vandps	1184(%rsp), %zmm1, %zmm11       # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm4, %zmm11, %zmm4
	vaddps	%zmm3, %zmm0, %zmm0
	vaddps	%zmm4, %zmm2, %zmm4
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm5, %zmm2
	vandps	%zmm1, %zmm7, %zmm3
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm3, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm23, %zmm3
	vandps	1248(%rsp), %zmm1, %zmm5        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm3, %zmm5, %zmm3
	vaddps	%zmm3, %zmm2, %zmm18
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm6, %zmm2
	vandps	%zmm1, %zmm8, %zmm3
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm3, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	160(%rsp), %zmm1, %zmm3         # 64-byte Folded Reload
	vandps	1376(%rsp), %zmm1, %zmm5        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm3, %zmm5, %zmm3
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm10, %zmm5
	vandps	%zmm1, %zmm13, %zmm6
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm6, %zmm5
	vaddps	%zmm3, %zmm2, %zmm3
	.loc	2 266 46                        # standard.py:266:46
	vandps	288(%rsp), %zmm1, %zmm2         # 64-byte Folded Reload
	vandps	1440(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm6, %zmm2
	vaddps	%zmm2, %zmm5, %zmm13
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm12, %zmm2
	vandps	%zmm1, %zmm9, %zmm5
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	416(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	vandps	1504(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm6, %zmm5
	vaddps	%zmm5, %zmm2, %zmm11
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm14, %zmm2
	vandps	%zmm1, %zmm15, %zmm5
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	544(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	vandps	1568(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm6, %zmm5
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm16, %zmm6
	vandps	%zmm1, %zmm17, %zmm7
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm6, %zmm7, %zmm6
	.loc	2 266 46                        # standard.py:266:46
	vandps	672(%rsp), %zmm1, %zmm7         # 64-byte Folded Reload
	vandps	1632(%rsp), %zmm1, %zmm8        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm7, %zmm8, %zmm7
	vaddps	%zmm5, %zmm2, %zmm15
	vaddps	%zmm7, %zmm6, %zmm23
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm19, %zmm2
	vandps	%zmm1, %zmm20, %zmm5
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	736(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	vandps	1696(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm6, %zmm5
	vaddps	%zmm5, %zmm2, %zmm9
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm27, %zmm2
	vandps	%zmm1, %zmm21, %zmm5
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	800(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	vandps	1760(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm6, %zmm5
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm29, %zmm6
	vandps	%zmm1, %zmm22, %zmm7
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm6, %zmm7, %zmm6
	vaddps	%zmm5, %zmm2, %zmm8
	.loc	2 266 46                        # standard.py:266:46
	vandps	864(%rsp), %zmm1, %zmm2         # 64-byte Folded Reload
	vandps	1824(%rsp), %zmm1, %zmm5        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	vaddps	%zmm2, %zmm6, %zmm7
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm28, %zmm2
	vandps	96(%rsp), %zmm1, %zmm5          # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	928(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	vandps	1888(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm6, %zmm5
	vaddps	%zmm5, %zmm2, %zmm17
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm30, %zmm2
	vandps	224(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	992(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	vandps	1952(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm6, %zmm5
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm31, %zmm6
	vandps	352(%rsp), %zmm1, %zmm10        # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm6, %zmm10, %zmm10
	.loc	2 266 46                        # standard.py:266:46
	vandps	1120(%rsp), %zmm1, %zmm6        # 64-byte Folded Reload
	vandps	2016(%rsp), %zmm1, %zmm12       # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm6, %zmm12, %zmm12
	vaddps	%zmm5, %zmm2, %zmm6
	vaddps	%zmm12, %zmm10, %zmm12
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm25, %zmm2
	vandps	480(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	1312(%rsp), %zmm1, %zmm5        # 64-byte Folded Reload
	vandps	2080(%rsp), %zmm1, %zmm10       # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm10, %zmm5
	vaddps	%zmm5, %zmm2, %zmm10
	.loc	2 266 46                        # standard.py:266:46
	vandps	%zmm1, %zmm24, %zmm2
	vandps	608(%rsp), %zmm1, %zmm5         # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm2, %zmm5, %zmm2
	.loc	2 266 46                        # standard.py:266:46
	vandps	32(%rsp), %zmm1, %zmm5          # 64-byte Folded Reload
	vandps	2144(%rsp), %zmm1, %zmm14       # 64-byte Folded Reload
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm14, %zmm5
	vaddps	%zmm5, %zmm2, %zmm2
	.loc	2 267 36                        # standard.py:267:36
	vshuff64x2	$78, %zmm0, %zmm0, %zmm5 # zmm5 = zmm0[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm0, %zmm0
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm0, %xmm5
	vaddps	%xmm5, %xmm0, %xmm0
	vshufpd	$1, %xmm0, %xmm0, %xmm5         # xmm5 = xmm0[1,0]
	vaddps	%xmm5, %xmm0, %xmm0
	vmovshdup	%xmm0, %xmm5            # xmm5 = xmm0[1,1,3,3]
	vaddss	%xmm5, %xmm0, %xmm0
	vshuff64x2	$78, %zmm4, %zmm4, %zmm5 # zmm5 = zmm4[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm5, %zmm4, %zmm4
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm4, %xmm5
	vaddps	%xmm5, %xmm4, %xmm4
	vshufpd	$1, %xmm4, %xmm4, %xmm5         # xmm5 = xmm4[1,0]
	vaddps	%xmm5, %xmm4, %xmm4
	vmovshdup	%xmm4, %xmm5            # xmm5 = xmm4[1,1,3,3]
	vaddss	%xmm5, %xmm4, %xmm5
	vshuff64x2	$78, %zmm18, %zmm18, %zmm4 # zmm4 = zmm18[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm4, %zmm18, %zmm4
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm4, %xmm14
	vaddps	%xmm4, %xmm14, %xmm4
	vshufpd	$1, %xmm4, %xmm4, %xmm14        # xmm14 = xmm4[1,0]
	vaddps	%xmm4, %xmm14, %xmm4
	vmovshdup	%xmm4, %xmm14           # xmm14 = xmm4[1,1,3,3]
	vaddss	%xmm4, %xmm14, %xmm4
	vshuff64x2	$78, %zmm3, %zmm3, %zmm14 # zmm14 = zmm3[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm14, %zmm3, %zmm3
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm3, %xmm14
	vaddps	%xmm3, %xmm14, %xmm3
	vshufpd	$1, %xmm3, %xmm3, %xmm14        # xmm14 = xmm3[1,0]
	vaddps	%xmm3, %xmm14, %xmm3
	vmovshdup	%xmm3, %xmm14           # xmm14 = xmm3[1,1,3,3]
	vaddss	%xmm3, %xmm14, %xmm3
	vshuff64x2	$78, %zmm13, %zmm13, %zmm14 # zmm14 = zmm13[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm14, %zmm13, %zmm13
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm13, %xmm14
	vaddps	%xmm14, %xmm13, %xmm13
	vshufpd	$1, %xmm13, %xmm13, %xmm14      # xmm14 = xmm13[1,0]
	vaddps	%xmm14, %xmm13, %xmm13
	vmovshdup	%xmm13, %xmm14          # xmm14 = xmm13[1,1,3,3]
	vaddss	%xmm14, %xmm13, %xmm13
	vshuff64x2	$78, %zmm11, %zmm11, %zmm14 # zmm14 = zmm11[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm14, %zmm11, %zmm11
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm11, %xmm14
	vaddps	%xmm14, %xmm11, %xmm11
	vinsertps	$16, %xmm5, %xmm0, %xmm5 # xmm5 = xmm0[0],xmm5[0],xmm0[2,3]
	vshufpd	$1, %xmm11, %xmm11, %xmm0       # xmm0 = xmm11[1,0]
	vaddps	%xmm0, %xmm11, %xmm0
	vmovshdup	%xmm0, %xmm11           # xmm11 = xmm0[1,1,3,3]
	vaddss	%xmm0, %xmm11, %xmm0
	vinsertps	$16, %xmm0, %xmm13, %xmm11 # xmm11 = xmm13[0],xmm0[0],xmm13[2,3]
	vshuff64x2	$78, %zmm15, %zmm15, %zmm0 # zmm0 = zmm15[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm0, %zmm15, %zmm0
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm0, %xmm13
	vaddps	%xmm0, %xmm13, %xmm0
	vshufpd	$1, %xmm0, %xmm0, %xmm13        # xmm13 = xmm0[1,0]
	vaddps	%xmm0, %xmm13, %xmm0
	vmovshdup	%xmm0, %xmm13           # xmm13 = xmm0[1,1,3,3]
	vaddss	%xmm0, %xmm13, %xmm13
	vshuff64x2	$78, %zmm23, %zmm23, %zmm0 # zmm0 = zmm23[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm0, %zmm23, %zmm0
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm0, %xmm14
	vaddps	%xmm0, %xmm14, %xmm0
	vshufpd	$1, %xmm0, %xmm0, %xmm14        # xmm14 = xmm0[1,0]
	vaddps	%xmm0, %xmm14, %xmm0
	vmovshdup	%xmm0, %xmm14           # xmm14 = xmm0[1,1,3,3]
	vaddss	%xmm0, %xmm14, %xmm0
	vshuff64x2	$78, %zmm9, %zmm9, %zmm14 # zmm14 = zmm9[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm14, %zmm9, %zmm9
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm9, %xmm14
	vaddps	%xmm14, %xmm9, %xmm9
	vshufpd	$1, %xmm9, %xmm9, %xmm14        # xmm14 = xmm9[1,0]
	vaddps	%xmm14, %xmm9, %xmm9
	vmovshdup	%xmm9, %xmm14           # xmm14 = xmm9[1,1,3,3]
	vaddss	%xmm14, %xmm9, %xmm9
	vshuff64x2	$78, %zmm8, %zmm8, %zmm14 # zmm14 = zmm8[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm14, %zmm8, %zmm8
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm8, %xmm14
	vaddps	%xmm14, %xmm8, %xmm8
	vshufpd	$1, %xmm8, %xmm8, %xmm14        # xmm14 = xmm8[1,0]
	vaddps	%xmm14, %xmm8, %xmm8
	vinsertps	$32, %xmm4, %xmm5, %xmm4 # xmm4 = xmm5[0,1],xmm4[0],xmm5[3]
	vmovshdup	%xmm8, %xmm5            # xmm5 = xmm8[1,1,3,3]
	vaddss	%xmm5, %xmm8, %xmm5
	vinsertps	$16, %xmm5, %xmm9, %xmm5 # xmm5 = xmm9[0],xmm5[0],xmm9[2,3]
	vshuff64x2	$78, %zmm7, %zmm7, %zmm8 # zmm8 = zmm7[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm8, %zmm7, %zmm7
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm7, %xmm8
	vaddps	%xmm7, %xmm8, %xmm7
	vshufpd	$1, %xmm7, %xmm7, %xmm8         # xmm8 = xmm7[1,0]
	vaddps	%xmm7, %xmm8, %xmm7
	vmovshdup	%xmm7, %xmm8            # xmm8 = xmm7[1,1,3,3]
	vaddss	%xmm7, %xmm8, %xmm7
	vinsertps	$32, %xmm13, %xmm11, %xmm8 # xmm8 = xmm11[0,1],xmm13[0],xmm11[3]
	vinsertps	$32, %xmm7, %xmm5, %xmm5 # xmm5 = xmm5[0,1],xmm7[0],xmm5[3]
	vshuff64x2	$78, %zmm17, %zmm17, %zmm7 # zmm7 = zmm17[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm7, %zmm17, %zmm7
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm7, %xmm9
	vaddps	%xmm7, %xmm9, %xmm7
	vshufpd	$1, %xmm7, %xmm7, %xmm9         # xmm9 = xmm7[1,0]
	vaddps	%xmm7, %xmm9, %xmm7
	vmovshdup	%xmm7, %xmm9            # xmm9 = xmm7[1,1,3,3]
	vaddss	%xmm7, %xmm9, %xmm7
	vshuff64x2	$78, %zmm6, %zmm6, %zmm9 # zmm9 = zmm6[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm9, %zmm6, %zmm6
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm6, %xmm9
	vaddps	%xmm6, %xmm9, %xmm6
	vshufpd	$1, %xmm6, %xmm6, %xmm9         # xmm9 = xmm6[1,0]
	vaddps	%xmm6, %xmm9, %xmm6
	vmovshdup	%xmm6, %xmm9            # xmm9 = xmm6[1,1,3,3]
	vaddss	%xmm6, %xmm9, %xmm6
	vshuff64x2	$78, %zmm12, %zmm12, %zmm9 # zmm9 = zmm12[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm9, %zmm12, %zmm9
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm9, %xmm11
	vaddps	%xmm11, %xmm9, %xmm9
	vshufpd	$1, %xmm9, %xmm9, %xmm11        # xmm11 = xmm9[1,0]
	vaddps	%xmm11, %xmm9, %xmm9
	vinsertps	$48, %xmm3, %xmm4, %xmm3 # xmm3 = xmm4[0,1,2],xmm3[0]
	vmovshdup	%xmm9, %xmm4            # xmm4 = xmm9[1,1,3,3]
	vaddss	%xmm4, %xmm9, %xmm4
	vinsertps	$16, %xmm4, %xmm6, %xmm4 # xmm4 = xmm6[0],xmm4[0],xmm6[2,3]
	vshuff64x2	$78, %zmm10, %zmm10, %zmm6 # zmm6 = zmm10[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm6, %zmm10, %zmm6
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm6, %xmm9
	vaddps	%xmm6, %xmm9, %xmm6
	vshufpd	$1, %xmm6, %xmm6, %xmm9         # xmm9 = xmm6[1,0]
	vaddps	%xmm6, %xmm9, %xmm6
	vmovshdup	%xmm6, %xmm9            # xmm9 = xmm6[1,1,3,3]
	vaddss	%xmm6, %xmm9, %xmm6
	vinsertps	$48, %xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0,1,2],xmm0[0]
	vinsertps	$32, %xmm6, %xmm4, %xmm4 # xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
	vshuff64x2	$78, %zmm2, %zmm2, %zmm6 # zmm6 = zmm2[4,5,6,7,0,1,2,3]
	.loc	2 256 15                        # standard.py:256:15
	vaddps	%zmm6, %zmm2, %zmm2
	.loc	2 267 36                        # standard.py:267:36
	vextractf128	$1, %ymm2, %xmm6
	vaddps	%xmm6, %xmm2, %xmm2
	vinsertps	$48, %xmm7, %xmm5, %xmm5 # xmm5 = xmm5[0,1,2],xmm7[0]
	vshufpd	$1, %xmm2, %xmm2, %xmm6         # xmm6 = xmm2[1,0]
	vaddps	%xmm6, %xmm2, %xmm2
	vmovshdup	%xmm2, %xmm6            # xmm6 = xmm2[1,1,3,3]
	vaddss	%xmm6, %xmm2, %xmm2
	vinsertps	$48, %xmm2, %xmm4, %xmm2 # xmm2 = xmm4[0,1,2],xmm2[0]
	vinsertf128	$1, %xmm2, %ymm5, %ymm2
	vinsertf128	$1, %xmm0, %ymm3, %ymm0
	vinsertf64x4	$1, %ymm2, %zmm0, %zmm0
	vmovups	2208(%rsp), %zmm2               # 64-byte Reload
.Ltmp3:
	.loc	1 40 15                         # matrix-vector-multiplication-bf16.py:40:15
	vaddps	%zmm0, %zmm2, %zmm2
	.loc	1 37 25                         # matrix-vector-multiplication-bf16.py:37:25
	addl	$64, %eax
	subq	$-128, %rdx
	cmpl	-88(%rsp), %eax                 # 4-byte Folded Reload
	jl	.LBB0_3
# %bb.4:                                # %._crit_edge.loopexit
	.loc	1 44 15                         # matrix-vector-multiplication-bf16.py:44:15
	vpsrld	$16, %zmm2, %zmm0
	vpmovdw	%zmm0, %ymm0
	movq	-72(%rsp), %rdi                 # 8-byte Reload
	movl	-92(%rsp), %r10d                # 4-byte Reload
	jmp	.LBB0_5
.LBB0_1:
	.loc	1 0 15 is_stmt 0                # matrix-vector-multiplication-bf16.py:0:15
	vpxor	%xmm0, %xmm0, %xmm0
.LBB0_5:                                # %._crit_edge
	.loc	1 45 12 is_stmt 1               # matrix-vector-multiplication-bf16.py:45:12
	movslq	%r10d, %rax
	.loc	1 46 16                         # matrix-vector-multiplication-bf16.py:46:16
	vmovdqu	%ymm0, (%rdi,%rax,2)
	.loc	1 46 4 epilogue_begin is_stmt 0 # matrix-vector-multiplication-bf16.py:46:4
	addq	$2280, %rsp                     # imm = 0x8E8
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	vzeroupper
	retq
.Ltmp4:
.Lfunc_end0:
	.size	gemv_kernel, .Lfunc_end0-gemv_kernel
	.cfi_endproc
                                        # -- End function
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	1                               # DW_CHILDREN_yes
	.byte	37                              # DW_AT_producer
	.byte	14                              # DW_FORM_strp
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	14                              # DW_FORM_strp
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	2                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	32                              # DW_AT_inline
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	3                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	4                               # Abbreviation Code
	.byte	29                              # DW_TAG_inlined_subroutine
	.byte	0                               # DW_CHILDREN_no
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	88                              # DW_AT_call_file
	.byte	11                              # DW_FORM_data1
	.byte	89                              # DW_AT_call_line
	.byte	11                              # DW_FORM_data1
	.byte	87                              # DW_AT_call_column
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.short	4                               # DWARF version number
	.long	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	8                               # Address Size (in bytes)
	.byte	1                               # Abbrev [1] 0xb:0x4c DW_TAG_compile_unit
	.long	.Linfo_string0                  # DW_AT_producer
	.short	2                               # DW_AT_language
	.long	.Linfo_string1                  # DW_AT_name
	.long	.Lline_table_start0             # DW_AT_stmt_list
	.long	.Linfo_string2                  # DW_AT_comp_dir
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.byte	2                               # Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  # DW_AT_name
	.byte	1                               # DW_AT_inline
	.byte	3                               # Abbrev [3] 0x30:0x26 DW_TAG_subprogram
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.long	42                              # DW_AT_abstract_origin
	.byte	4                               # Abbrev [4] 0x41:0x14 DW_TAG_inlined_subroutine
	.long	42                              # DW_AT_abstract_origin
	.quad	.Ltmp2                          # DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	40                              # DW_AT_call_line
	.byte	22                              # DW_AT_call_column
	.byte	0                               # End Of Children Mark
	.byte	0                               # End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"triton"                        # string offset=0
.Linfo_string1:
	.asciz	"matrix-vector-multiplication-bf16.py" # string offset=7
.Linfo_string2:
	.asciz	"/root/triton/triton-cpu/./python/tutorials" # string offset=44
.Linfo_string3:
	.asciz	"gemv_kernel"                   # string offset=87
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
