; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@global_smem = external addrspace(3) global [0 x i8], align 16

define void @softmax_kernel(ptr addrspace(1) %0, ptr addrspace(1) %1, i32 %2, i32 %3, i32 %4, i32 %5) {
  %7 = call i32 asm "mov.u32 $0, %ctaid.x;", "=r"()
  %8 = call i32 asm "mov.u32 $0, %nctaid.x;", "=r"()
  %9 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %10 = urem i32 %9, 32
  %11 = udiv i32 %9, 32
  %12 = and i32 %10, 1
  %13 = icmp eq i32 %12, 0
  %14 = select i1 %13, i32 0, i32 4
  %15 = xor i32 0, %14
  %16 = and i32 %10, 2
  %17 = icmp eq i32 %16, 0
  %18 = select i1 %17, i32 0, i32 8
  %19 = xor i32 %15, %18
  %20 = and i32 %10, 4
  %21 = icmp eq i32 %20, 0
  %22 = select i1 %21, i32 0, i32 16
  %23 = xor i32 %19, %22
  %24 = and i32 %10, 8
  %25 = icmp eq i32 %24, 0
  %26 = select i1 %25, i32 0, i32 32
  %27 = xor i32 %23, %26
  %28 = and i32 %10, 16
  %29 = icmp eq i32 %28, 0
  %30 = select i1 %29, i32 0, i32 64
  %31 = xor i32 %27, %30
  %32 = and i32 %11, 1
  %33 = icmp eq i32 %32, 0
  %34 = select i1 %33, i32 0, i32 128
  %35 = xor i32 %31, %34
  %36 = and i32 %11, 2
  %37 = icmp eq i32 %36, 0
  %38 = select i1 %37, i32 0, i32 256
  %39 = xor i32 %35, %38
  %40 = and i32 %11, 4
  %41 = icmp eq i32 %40, 0
  %42 = select i1 %41, i32 0, i32 512
  %43 = xor i32 %39, %42
  %44 = and i32 %10, 1
  %45 = icmp eq i32 %44, 0
  %46 = select i1 %45, i32 0, i32 4
  %47 = xor i32 1024, %46
  %48 = and i32 %10, 2
  %49 = icmp eq i32 %48, 0
  %50 = select i1 %49, i32 0, i32 8
  %51 = xor i32 %47, %50
  %52 = and i32 %10, 4
  %53 = icmp eq i32 %52, 0
  %54 = select i1 %53, i32 0, i32 16
  %55 = xor i32 %51, %54
  %56 = and i32 %10, 8
  %57 = icmp eq i32 %56, 0
  %58 = select i1 %57, i32 0, i32 32
  %59 = xor i32 %55, %58
  %60 = and i32 %10, 16
  %61 = icmp eq i32 %60, 0
  %62 = select i1 %61, i32 0, i32 64
  %63 = xor i32 %59, %62
  %64 = and i32 %11, 1
  %65 = icmp eq i32 %64, 0
  %66 = select i1 %65, i32 0, i32 128
  %67 = xor i32 %63, %66
  %68 = and i32 %11, 2
  %69 = icmp eq i32 %68, 0
  %70 = select i1 %69, i32 0, i32 256
  %71 = xor i32 %67, %70
  %72 = and i32 %11, 4
  %73 = icmp eq i32 %72, 0
  %74 = select i1 %73, i32 0, i32 512
  %75 = xor i32 %71, %74
  %76 = add i32 %43, 0
  %77 = add i32 %75, 0
  %78 = icmp slt i32 %76, %5
  %79 = icmp slt i32 %77, %5
  br label %80

80:                                               ; preds = %83, %6
  %81 = phi i32 [ %280, %83 ], [ %7, %6 ]
  %82 = icmp slt i32 %81, %4
  br i1 %82, label %83, label %281

83:                                               ; preds = %80
  %84 = mul i32 %81, %2
  %85 = getelementptr float, ptr addrspace(1) %1, i32 %84
  %86 = getelementptr float, ptr addrspace(1) %85, i32 %76
  %87 = getelementptr float, ptr addrspace(1) %85, i32 %77
  %88 = call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];\0A\09@!$7 mov.u32 $0, $6;\0A\09@!$9 mov.u32 $1, $8;\0A\09@!$11 mov.u32 $2, $10;\0A\09@!$13 mov.u32 $3, $12;", "=r,=r,=r,=r,l,b,r,b,r,b,r,b,r,b"(ptr addrspace(1) %86, i1 %78, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %78, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %78, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %78, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %78)
  %89 = extractvalue { i32, i32, i32, i32 } %88, 0
  %90 = bitcast i32 %89 to <1 x float>
  %91 = extractvalue { i32, i32, i32, i32 } %88, 1
  %92 = bitcast i32 %91 to <1 x float>
  %93 = extractvalue { i32, i32, i32, i32 } %88, 2
  %94 = bitcast i32 %93 to <1 x float>
  %95 = extractvalue { i32, i32, i32, i32 } %88, 3
  %96 = bitcast i32 %95 to <1 x float>
  %97 = extractelement <1 x float> %90, i32 0
  %98 = extractelement <1 x float> %92, i32 0
  %99 = extractelement <1 x float> %94, i32 0
  %100 = extractelement <1 x float> %96, i32 0
  %101 = call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];\0A\09@!$7 mov.u32 $0, $6;\0A\09@!$9 mov.u32 $1, $8;\0A\09@!$11 mov.u32 $2, $10;\0A\09@!$13 mov.u32 $3, $12;", "=r,=r,=r,=r,l,b,r,b,r,b,r,b,r,b"(ptr addrspace(1) %87, i1 %79, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %79, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %79, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %79, i32 bitcast (<1 x float> <float 0xFFF0000000000000> to i32), i1 %79)
  %102 = extractvalue { i32, i32, i32, i32 } %101, 0
  %103 = bitcast i32 %102 to <1 x float>
  %104 = extractvalue { i32, i32, i32, i32 } %101, 1
  %105 = bitcast i32 %104 to <1 x float>
  %106 = extractvalue { i32, i32, i32, i32 } %101, 2
  %107 = bitcast i32 %106 to <1 x float>
  %108 = extractvalue { i32, i32, i32, i32 } %101, 3
  %109 = bitcast i32 %108 to <1 x float>
  %110 = extractelement <1 x float> %103, i32 0
  %111 = extractelement <1 x float> %105, i32 0
  %112 = extractelement <1 x float> %107, i32 0
  %113 = extractelement <1 x float> %109, i32 0
  call void @llvm.nvvm.barrier0()
  %114 = call float @llvm.maxnum.f32(float %97, float %98)
  %115 = call float @llvm.maxnum.f32(float %114, float %99)
  %116 = call float @llvm.maxnum.f32(float %115, float %100)
  %117 = call float @llvm.maxnum.f32(float %116, float %110)
  %118 = call float @llvm.maxnum.f32(float %117, float %111)
  %119 = call float @llvm.maxnum.f32(float %118, float %112)
  %120 = call float @llvm.maxnum.f32(float %119, float %113)
  %121 = bitcast float %120 to i32
  %122 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %121, i32 16, i32 31)
  %123 = bitcast i32 %122 to float
  %124 = call float @llvm.maxnum.f32(float %120, float %123)
  %125 = bitcast float %124 to i32
  %126 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %125, i32 8, i32 31)
  %127 = bitcast i32 %126 to float
  %128 = call float @llvm.maxnum.f32(float %124, float %127)
  %129 = bitcast float %128 to i32
  %130 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %129, i32 4, i32 31)
  %131 = bitcast i32 %130 to float
  %132 = call float @llvm.maxnum.f32(float %128, float %131)
  %133 = bitcast float %132 to i32
  %134 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %133, i32 2, i32 31)
  %135 = bitcast i32 %134 to float
  %136 = call float @llvm.maxnum.f32(float %132, float %135)
  %137 = bitcast float %136 to i32
  %138 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %137, i32 1, i32 31)
  %139 = bitcast i32 %138 to float
  %140 = call float @llvm.maxnum.f32(float %136, float %139)
  %141 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %142 = udiv i32 %141, 32
  %143 = urem i32 %141, 32
  %144 = urem i32 %143, 32
  %145 = icmp eq i32 %144, 0
  %146 = urem i32 %142, 8
  %147 = getelementptr float, ptr addrspace(3) @global_smem, i32 %146
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %147, float %140, i1 %145)
  call void @llvm.nvvm.barrier0()
  %148 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %149 = urem i32 %148, 32
  %150 = icmp slt i32 %148, 8
  %151 = getelementptr float, ptr addrspace(3) @global_smem, i32 %148
  %152 = call float asm sideeffect "@$2 ld.shared.b32 $0, [ $1 + 0 ];", "=r,r,b"(ptr addrspace(3) %151, i1 %150)
  %153 = bitcast float %152 to i32
  %154 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %153, i32 4, i32 31)
  %155 = bitcast i32 %154 to float
  %156 = call float @llvm.maxnum.f32(float %152, float %155)
  %157 = bitcast float %156 to i32
  %158 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %157, i32 2, i32 31)
  %159 = bitcast i32 %158 to float
  %160 = call float @llvm.maxnum.f32(float %156, float %159)
  %161 = bitcast float %160 to i32
  %162 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %161, i32 1, i32 31)
  %163 = bitcast i32 %162 to float
  %164 = call float @llvm.maxnum.f32(float %160, float %163)
  %165 = getelementptr float, ptr addrspace(3) @global_smem, i32 %148
  %166 = urem i32 %149, 8
  %167 = icmp eq i32 %166, 0
  %168 = and i1 %150, %167
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %165, float %164, i1 %168)
  call void @llvm.nvvm.barrier0()
  %169 = load float, ptr addrspace(3) @global_smem, align 4
  %170 = fsub float %97, %169
  %171 = fsub float %98, %169
  %172 = fsub float %99, %169
  %173 = fsub float %100, %169
  %174 = fsub float %110, %169
  %175 = fsub float %111, %169
  %176 = fsub float %112, %169
  %177 = fsub float %113, %169
  %178 = fmul float %170, 0x3FF7154760000000
  %179 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %178)
  %180 = fmul float %171, 0x3FF7154760000000
  %181 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %180)
  %182 = fmul float %172, 0x3FF7154760000000
  %183 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %182)
  %184 = fmul float %173, 0x3FF7154760000000
  %185 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %184)
  %186 = fmul float %174, 0x3FF7154760000000
  %187 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %186)
  %188 = fmul float %175, 0x3FF7154760000000
  %189 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %188)
  %190 = fmul float %176, 0x3FF7154760000000
  %191 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %190)
  %192 = fmul float %177, 0x3FF7154760000000
  %193 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %192)
  call void @llvm.nvvm.barrier0()
  %194 = fadd float %179, %181
  %195 = fadd float %194, %183
  %196 = fadd float %195, %185
  %197 = fadd float %196, %187
  %198 = fadd float %197, %189
  %199 = fadd float %198, %191
  %200 = fadd float %199, %193
  %201 = bitcast float %200 to i32
  %202 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %201, i32 16, i32 31)
  %203 = bitcast i32 %202 to float
  %204 = fadd float %200, %203
  %205 = bitcast float %204 to i32
  %206 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %205, i32 8, i32 31)
  %207 = bitcast i32 %206 to float
  %208 = fadd float %204, %207
  %209 = bitcast float %208 to i32
  %210 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %209, i32 4, i32 31)
  %211 = bitcast i32 %210 to float
  %212 = fadd float %208, %211
  %213 = bitcast float %212 to i32
  %214 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %213, i32 2, i32 31)
  %215 = bitcast i32 %214 to float
  %216 = fadd float %212, %215
  %217 = bitcast float %216 to i32
  %218 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %217, i32 1, i32 31)
  %219 = bitcast i32 %218 to float
  %220 = fadd float %216, %219
  %221 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %222 = udiv i32 %221, 32
  %223 = urem i32 %221, 32
  %224 = urem i32 %223, 32
  %225 = icmp eq i32 %224, 0
  %226 = urem i32 %222, 8
  %227 = getelementptr float, ptr addrspace(3) @global_smem, i32 %226
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %227, float %220, i1 %225)
  call void @llvm.nvvm.barrier0()
  %228 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %229 = urem i32 %228, 32
  %230 = icmp slt i32 %228, 8
  %231 = getelementptr float, ptr addrspace(3) @global_smem, i32 %228
  %232 = call float asm sideeffect "@$2 ld.shared.b32 $0, [ $1 + 0 ];", "=r,r,b"(ptr addrspace(3) %231, i1 %230)
  %233 = bitcast float %232 to i32
  %234 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %233, i32 4, i32 31)
  %235 = bitcast i32 %234 to float
  %236 = fadd float %232, %235
  %237 = bitcast float %236 to i32
  %238 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %237, i32 2, i32 31)
  %239 = bitcast i32 %238 to float
  %240 = fadd float %236, %239
  %241 = bitcast float %240 to i32
  %242 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %241, i32 1, i32 31)
  %243 = bitcast i32 %242 to float
  %244 = fadd float %240, %243
  %245 = getelementptr float, ptr addrspace(3) @global_smem, i32 %228
  %246 = urem i32 %229, 8
  %247 = icmp eq i32 %246, 0
  %248 = and i1 %230, %247
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %245, float %244, i1 %248)
  call void @llvm.nvvm.barrier0()
  %249 = load float, ptr addrspace(3) @global_smem, align 4
  %250 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %179, float %249)
  %251 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %181, float %249)
  %252 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %183, float %249)
  %253 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %185, float %249)
  %254 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %187, float %249)
  %255 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %189, float %249)
  %256 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %191, float %249)
  %257 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %193, float %249)
  %258 = mul i32 %81, %3
  %259 = getelementptr float, ptr addrspace(1) %0, i32 %258
  %260 = getelementptr float, ptr addrspace(1) %259, i32 %76
  %261 = getelementptr float, ptr addrspace(1) %259, i32 %77
  %262 = insertelement <1 x float> undef, float %250, i32 0
  %263 = bitcast <1 x float> %262 to i32
  %264 = insertelement <1 x float> undef, float %251, i32 0
  %265 = bitcast <1 x float> %264 to i32
  %266 = insertelement <1 x float> undef, float %252, i32 0
  %267 = bitcast <1 x float> %266 to i32
  %268 = insertelement <1 x float> undef, float %253, i32 0
  %269 = bitcast <1 x float> %268 to i32
  %270 = and i1 true, %78
  call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %263, i32 %265, i32 %267, i32 %269, ptr addrspace(1) %260, i1 %270)
  %271 = insertelement <1 x float> undef, float %254, i32 0
  %272 = bitcast <1 x float> %271 to i32
  %273 = insertelement <1 x float> undef, float %255, i32 0
  %274 = bitcast <1 x float> %273 to i32
  %275 = insertelement <1 x float> undef, float %256, i32 0
  %276 = bitcast <1 x float> %275 to i32
  %277 = insertelement <1 x float> undef, float %257, i32 0
  %278 = bitcast <1 x float> %277 to i32
  %279 = and i1 true, %79
  call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %272, i32 %274, i32 %276, i32 %278, ptr addrspace(1) %261, i1 %279)
  %280 = add i32 %81, %8
  br label %80

281:                                              ; preds = %80
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: convergent nocallback nounwind
declare void @llvm.nvvm.barrier0() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.maxnum.f32(float, float) #0

; Function Attrs: convergent nocallback nounwind memory(inaccessiblemem: readwrite)
declare i32 @llvm.nvvm.shfl.sync.bfly.i32(i32, i32, i32, i32) #2

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { convergent nocallback nounwind }
attributes #2 = { convergent nocallback nounwind memory(inaccessiblemem: readwrite) }

!llvm.module.flags = !{!0}
!nvvm.annotations = !{!1, !2}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{ptr @softmax_kernel, !"kernel", i32 1}
!2 = !{ptr @softmax_kernel, !"maxntidx", i32 256}
