; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@global_smem = external addrspace(3) global [0 x i8], align 16

define void @add_kernel(ptr addrspace(1) %0, ptr addrspace(1) %1, ptr addrspace(1) %2, i32 %3, ptr addrspace(1) %4) {
  %6 = call i32 asm "mov.u32 $0, %ctaid.x;", "=r"()
  %7 = mul i32 %6, 1024
  %8 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %9 = urem i32 %8, 32
  %10 = udiv i32 %8, 32
  %11 = and i32 %9, 1
  %12 = icmp eq i32 %11, 0
  %13 = select i1 %12, i32 0, i32 4
  %14 = xor i32 0, %13
  %15 = and i32 %9, 2
  %16 = icmp eq i32 %15, 0
  %17 = select i1 %16, i32 0, i32 8
  %18 = xor i32 %14, %17
  %19 = and i32 %9, 4
  %20 = icmp eq i32 %19, 0
  %21 = select i1 %20, i32 0, i32 16
  %22 = xor i32 %18, %21
  %23 = and i32 %9, 8
  %24 = icmp eq i32 %23, 0
  %25 = select i1 %24, i32 0, i32 32
  %26 = xor i32 %22, %25
  %27 = and i32 %9, 16
  %28 = icmp eq i32 %27, 0
  %29 = select i1 %28, i32 0, i32 64
  %30 = xor i32 %26, %29
  %31 = and i32 %10, 1
  %32 = icmp eq i32 %31, 0
  %33 = select i1 %32, i32 0, i32 128
  %34 = xor i32 %30, %33
  %35 = and i32 %10, 2
  %36 = icmp eq i32 %35, 0
  %37 = select i1 %36, i32 0, i32 256
  %38 = xor i32 %34, %37
  %39 = xor i32 %38, 0
  %40 = xor i32 %38, 512
  %41 = add i32 %39, 0
  %42 = add i32 %40, 0
  %43 = add i32 %7, %41
  %44 = add i32 %7, %42
  %45 = icmp slt i32 %43, %3
  %46 = icmp slt i32 %44, %3
  %47 = getelementptr float, ptr addrspace(1) %0, i32 %43
  %48 = getelementptr float, ptr addrspace(1) %0, i32 %44
  %49 = call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l,b"(ptr addrspace(1) %47, i1 %45)
  %50 = extractvalue { i32, i32, i32, i32 } %49, 0
  %51 = bitcast i32 %50 to <1 x float>
  %52 = extractvalue { i32, i32, i32, i32 } %49, 1
  %53 = bitcast i32 %52 to <1 x float>
  %54 = extractvalue { i32, i32, i32, i32 } %49, 2
  %55 = bitcast i32 %54 to <1 x float>
  %56 = extractvalue { i32, i32, i32, i32 } %49, 3
  %57 = bitcast i32 %56 to <1 x float>
  %58 = extractelement <1 x float> %51, i32 0
  %59 = extractelement <1 x float> %53, i32 0
  %60 = extractelement <1 x float> %55, i32 0
  %61 = extractelement <1 x float> %57, i32 0
  %62 = call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l,b"(ptr addrspace(1) %48, i1 %46)
  %63 = extractvalue { i32, i32, i32, i32 } %62, 0
  %64 = bitcast i32 %63 to <1 x float>
  %65 = extractvalue { i32, i32, i32, i32 } %62, 1
  %66 = bitcast i32 %65 to <1 x float>
  %67 = extractvalue { i32, i32, i32, i32 } %62, 2
  %68 = bitcast i32 %67 to <1 x float>
  %69 = extractvalue { i32, i32, i32, i32 } %62, 3
  %70 = bitcast i32 %69 to <1 x float>
  %71 = extractelement <1 x float> %64, i32 0
  %72 = extractelement <1 x float> %66, i32 0
  %73 = extractelement <1 x float> %68, i32 0
  %74 = extractelement <1 x float> %70, i32 0
  %75 = getelementptr float, ptr addrspace(1) %1, i32 %43
  %76 = getelementptr float, ptr addrspace(1) %1, i32 %44
  %77 = call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l,b"(ptr addrspace(1) %75, i1 %45)
  %78 = extractvalue { i32, i32, i32, i32 } %77, 0
  %79 = bitcast i32 %78 to <1 x float>
  %80 = extractvalue { i32, i32, i32, i32 } %77, 1
  %81 = bitcast i32 %80 to <1 x float>
  %82 = extractvalue { i32, i32, i32, i32 } %77, 2
  %83 = bitcast i32 %82 to <1 x float>
  %84 = extractvalue { i32, i32, i32, i32 } %77, 3
  %85 = bitcast i32 %84 to <1 x float>
  %86 = extractelement <1 x float> %79, i32 0
  %87 = extractelement <1 x float> %81, i32 0
  %88 = extractelement <1 x float> %83, i32 0
  %89 = extractelement <1 x float> %85, i32 0
  %90 = call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l,b"(ptr addrspace(1) %76, i1 %46)
  %91 = extractvalue { i32, i32, i32, i32 } %90, 0
  %92 = bitcast i32 %91 to <1 x float>
  %93 = extractvalue { i32, i32, i32, i32 } %90, 1
  %94 = bitcast i32 %93 to <1 x float>
  %95 = extractvalue { i32, i32, i32, i32 } %90, 2
  %96 = bitcast i32 %95 to <1 x float>
  %97 = extractvalue { i32, i32, i32, i32 } %90, 3
  %98 = bitcast i32 %97 to <1 x float>
  %99 = extractelement <1 x float> %92, i32 0
  %100 = extractelement <1 x float> %94, i32 0
  %101 = extractelement <1 x float> %96, i32 0
  %102 = extractelement <1 x float> %98, i32 0
  %103 = fadd float %58, %86
  %104 = fadd float %59, %87
  %105 = fadd float %60, %88
  %106 = fadd float %61, %89
  %107 = fadd float %71, %99
  %108 = fadd float %72, %100
  %109 = fadd float %73, %101
  %110 = fadd float %74, %102
  %111 = getelementptr float, ptr addrspace(1) %2, i32 %43
  %112 = getelementptr float, ptr addrspace(1) %2, i32 %44
  %113 = insertelement <1 x float> undef, float %103, i32 0
  %114 = bitcast <1 x float> %113 to i32
  %115 = insertelement <1 x float> undef, float %104, i32 0
  %116 = bitcast <1 x float> %115 to i32
  %117 = insertelement <1 x float> undef, float %105, i32 0
  %118 = bitcast <1 x float> %117 to i32
  %119 = insertelement <1 x float> undef, float %106, i32 0
  %120 = bitcast <1 x float> %119 to i32
  %121 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %122 = urem i32 %121, 32
  %123 = udiv i32 %121, 32
  %124 = and i32 0, %122
  %125 = icmp eq i32 %124, 0
  %126 = and i1 true, %125
  %127 = and i32 0, %123
  %128 = icmp eq i32 %127, 0
  %129 = and i1 %126, %128
  %130 = and i1 %129, %45
  call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %114, i32 %116, i32 %118, i32 %120, ptr addrspace(1) %111, i1 %130)
  %131 = insertelement <1 x float> undef, float %107, i32 0
  %132 = bitcast <1 x float> %131 to i32
  %133 = insertelement <1 x float> undef, float %108, i32 0
  %134 = bitcast <1 x float> %133 to i32
  %135 = insertelement <1 x float> undef, float %109, i32 0
  %136 = bitcast <1 x float> %135 to i32
  %137 = insertelement <1 x float> undef, float %110, i32 0
  %138 = bitcast <1 x float> %137 to i32
  %139 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %140 = urem i32 %139, 32
  %141 = udiv i32 %139, 32
  %142 = and i32 0, %140
  %143 = icmp eq i32 %142, 0
  %144 = and i1 true, %143
  %145 = and i32 0, %141
  %146 = icmp eq i32 %145, 0
  %147 = and i1 %144, %146
  %148 = and i1 %147, %46
  call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %132, i32 %134, i32 %136, i32 %138, ptr addrspace(1) %112, i1 %148)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}
!nvvm.annotations = !{!1, !2}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{ptr @add_kernel, !"kernel", i32 1}
!2 = !{ptr @add_kernel, !"reqntidx", i32 128}
