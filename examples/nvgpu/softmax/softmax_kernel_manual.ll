; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@global_smem = external addrspace(3) global [0 x i8], align 16

define void @softmax_kernel(ptr addrspace(1) %0, ptr addrspace(1) %1, i32 %2, i32 %3, i32 %4, i32 %5, ptr addrspace(1) %6) {
  %8 = call i32 asm "mov.u32 $0, %ctaid.x;", "=r"()
  %9 = call i32 asm "mov.u32 $0, %nctaid.x;", "=r"()
  %10 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %11 = urem i32 %10, 32
  %12 = udiv i32 %10, 32
  %13 = and i32 %11, 1
  %14 = icmp eq i32 %13, 0
  %15 = select i1 %14, i32 0, i32 1
  %16 = xor i32 0, %15
  %17 = and i32 %11, 2
  %18 = icmp eq i32 %17, 0
  %19 = select i1 %18, i32 0, i32 2
  %20 = xor i32 %16, %19
  %21 = and i32 %11, 4
  %22 = icmp eq i32 %21, 0
  %23 = select i1 %22, i32 0, i32 4
  %24 = xor i32 %20, %23
  %25 = and i32 %11, 8
  %26 = icmp eq i32 %25, 0
  %27 = select i1 %26, i32 0, i32 8
  %28 = xor i32 %24, %27
  %29 = and i32 %11, 16
  %30 = icmp eq i32 %29, 0
  %31 = select i1 %30, i32 0, i32 16
  %32 = xor i32 %28, %31
  %33 = and i32 %12, 1
  %34 = icmp eq i32 %33, 0
  %35 = select i1 %34, i32 0, i32 32
  %36 = xor i32 %32, %35
  %37 = and i32 %12, 2
  %38 = icmp eq i32 %37, 0
  %39 = select i1 %38, i32 0, i32 64
  %40 = xor i32 %36, %39
  %41 = and i32 %12, 4
  %42 = icmp eq i32 %41, 0
  %43 = select i1 %42, i32 0, i32 128
  %44 = xor i32 %40, %43
  %45 = xor i32 %44, 0
  %46 = add i32 %45, 0
  %47 = icmp slt i32 %46, %5
  %48 = icmp slt i32 %8, %4
  %49 = mul i32 %8, %2
  %50 = getelementptr float, ptr addrspace(1) %1, i32 %49
  %51 = getelementptr float, ptr addrspace(1) %50, i32 %46
  %52 = and i1 %48, %47
  %53 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %54 = urem i32 %53, 32
  %55 = udiv i32 %53, 32
  %56 = and i32 %54, 1
  %57 = icmp eq i32 %56, 0
  %58 = select i1 %57, i32 0, i32 1
  %59 = xor i32 0, %58
  %60 = and i32 %54, 2
  %61 = icmp eq i32 %60, 0
  %62 = select i1 %61, i32 0, i32 2
  %63 = xor i32 %59, %62
  %64 = and i32 %54, 4
  %65 = icmp eq i32 %64, 0
  %66 = select i1 %65, i32 0, i32 4
  %67 = xor i32 %63, %66
  %68 = and i32 %54, 8
  %69 = icmp eq i32 %68, 0
  %70 = select i1 %69, i32 0, i32 8
  %71 = xor i32 %67, %70
  %72 = and i32 %54, 16
  %73 = icmp eq i32 %72, 0
  %74 = select i1 %73, i32 0, i32 16
  %75 = xor i32 %71, %74
  %76 = and i32 %55, 1
  %77 = icmp eq i32 %76, 0
  %78 = select i1 %77, i32 0, i32 32
  %79 = xor i32 %75, %78
  %80 = and i32 %55, 2
  %81 = icmp eq i32 %80, 0
  %82 = select i1 %81, i32 0, i32 64
  %83 = xor i32 %79, %82
  %84 = and i32 %55, 4
  %85 = icmp eq i32 %84, 0
  %86 = select i1 %85, i32 0, i32 128
  %87 = xor i32 %83, %86
  %88 = mul i32 %87, 1
  %89 = add i32 %88, 0
  %90 = getelementptr inbounds float, ptr addrspace(3) @global_smem, i32 %89
  %91 = select i1 %52, i32 4, i32 0
  %92 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %93 = urem i32 %92, 32
  %94 = udiv i32 %92, 32
  %95 = and i32 0, %93
  %96 = icmp eq i32 %95, 0
  %97 = and i1 true, %96
  %98 = and i32 0, %94
  %99 = icmp eq i32 %98, 0
  %100 = and i1 %97, %99
  call void asm sideeffect "@$3 cp.async.ca.shared.global [ $0 + 0 ], [ $1 + 0 ], 0x4, $2;", "r,l,r,b"(ptr addrspace(3) %90, ptr addrspace(1) %51, i32 %91, i1 %100)
  call void asm sideeffect "cp.async.commit_group ;", ""()
  br label %101

101:                                              ; preds = %106, %7
  %102 = phi i32 [ %360, %106 ], [ %8, %7 ]
  %103 = phi i32 [ %302, %106 ], [ 0, %7 ]
  %104 = phi i32 [ %111, %106 ], [ -1, %7 ]
  %105 = icmp slt i32 %102, %4
  br i1 %105, label %106, label %361

106:                                              ; preds = %101
  %107 = sub i32 %4, %9
  %108 = icmp slt i32 %102, %107
  %109 = add i32 %104, 1
  %110 = icmp slt i32 %109, 1
  %111 = select i1 %110, i32 %109, i32 0
  call void asm sideeffect "cp.async.wait_group 0x0;", ""()
  call void @llvm.nvvm.barrier0()
  %112 = mul i32 %111, 256
  %113 = add i32 %112, 0
  %114 = add i32 %113, 0
  %115 = getelementptr float, ptr addrspace(3) @global_smem, i32 %114
  %116 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %117 = urem i32 %116, 32
  %118 = udiv i32 %116, 32
  %119 = and i32 %117, 1
  %120 = icmp eq i32 %119, 0
  %121 = select i1 %120, i32 0, i32 1
  %122 = xor i32 0, %121
  %123 = and i32 %117, 2
  %124 = icmp eq i32 %123, 0
  %125 = select i1 %124, i32 0, i32 2
  %126 = xor i32 %122, %125
  %127 = and i32 %117, 4
  %128 = icmp eq i32 %127, 0
  %129 = select i1 %128, i32 0, i32 4
  %130 = xor i32 %126, %129
  %131 = and i32 %117, 8
  %132 = icmp eq i32 %131, 0
  %133 = select i1 %132, i32 0, i32 8
  %134 = xor i32 %130, %133
  %135 = and i32 %117, 16
  %136 = icmp eq i32 %135, 0
  %137 = select i1 %136, i32 0, i32 16
  %138 = xor i32 %134, %137
  %139 = and i32 %118, 1
  %140 = icmp eq i32 %139, 0
  %141 = select i1 %140, i32 0, i32 32
  %142 = xor i32 %138, %141
  %143 = and i32 %118, 2
  %144 = icmp eq i32 %143, 0
  %145 = select i1 %144, i32 0, i32 64
  %146 = xor i32 %142, %145
  %147 = and i32 %118, 4
  %148 = icmp eq i32 %147, 0
  %149 = select i1 %148, i32 0, i32 128
  %150 = xor i32 %146, %149
  %151 = mul i32 %150, 1
  %152 = add i32 %151, 0
  %153 = getelementptr inbounds float, ptr addrspace(3) %115, i32 %152
  %154 = load <1 x float>, ptr addrspace(3) %153, align 4
  %155 = extractelement <1 x float> %154, i32 0
  %156 = select i1 %47, float %155, float 0xFFF0000000000000
  %157 = bitcast float %156 to i32
  %158 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %157, i32 16, i32 31)
  %159 = bitcast i32 %158 to float
  %160 = call float @llvm.maxnum.f32(float %156, float %159)
  %161 = bitcast float %160 to i32
  %162 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %161, i32 8, i32 31)
  %163 = bitcast i32 %162 to float
  %164 = call float @llvm.maxnum.f32(float %160, float %163)
  %165 = bitcast float %164 to i32
  %166 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %165, i32 4, i32 31)
  %167 = bitcast i32 %166 to float
  %168 = call float @llvm.maxnum.f32(float %164, float %167)
  %169 = bitcast float %168 to i32
  %170 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %169, i32 2, i32 31)
  %171 = bitcast i32 %170 to float
  %172 = call float @llvm.maxnum.f32(float %168, float %171)
  %173 = bitcast float %172 to i32
  %174 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %173, i32 1, i32 31)
  %175 = bitcast i32 %174 to float
  %176 = call float @llvm.maxnum.f32(float %172, float %175)
  %177 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %178 = udiv i32 %177, 32
  %179 = urem i32 %177, 32
  %180 = urem i32 %179, 32
  %181 = icmp eq i32 %180, 0
  %182 = urem i32 %178, 8
  %183 = getelementptr float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), i32 %182
  %184 = insertelement <1 x float> undef, float %176, i32 0
  %185 = extractelement <1 x float> %184, i32 0
  %186 = bitcast float %185 to i32
  %187 = insertelement <1 x i32> undef, i32 %186, i32 0
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %183, <1 x i32> %187, i1 %181)
  call void @llvm.nvvm.barrier0()
  %188 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %189 = urem i32 %188, 32
  %190 = icmp slt i32 %188, 8
  %191 = getelementptr float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), i32 %188
  %192 = call i32 asm sideeffect "@$2 ld.shared.b32 $0, [ $1 + 0 ];", "=r,r,b"(ptr addrspace(3) %191, i1 %190)
  %193 = insertelement <1 x i32> undef, i32 %192, i32 0
  %194 = extractelement <1 x i32> %193, i32 0
  %195 = bitcast i32 %194 to float
  %196 = insertelement <1 x float> undef, float %195, i32 0
  %197 = extractelement <1 x float> %196, i32 0
  %198 = bitcast float %197 to i32
  %199 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %198, i32 4, i32 31)
  %200 = bitcast i32 %199 to float
  %201 = call float @llvm.maxnum.f32(float %197, float %200)
  %202 = bitcast float %201 to i32
  %203 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %202, i32 2, i32 31)
  %204 = bitcast i32 %203 to float
  %205 = call float @llvm.maxnum.f32(float %201, float %204)
  %206 = bitcast float %205 to i32
  %207 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %206, i32 1, i32 31)
  %208 = bitcast i32 %207 to float
  %209 = call float @llvm.maxnum.f32(float %205, float %208)
  %210 = getelementptr float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), i32 %188
  %211 = urem i32 %189, 8
  %212 = icmp eq i32 %211, 0
  %213 = and i1 %190, %212
  %214 = insertelement <1 x float> undef, float %209, i32 0
  %215 = extractelement <1 x float> %214, i32 0
  %216 = bitcast float %215 to i32
  %217 = insertelement <1 x i32> undef, i32 %216, i32 0
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %210, <1 x i32> %217, i1 %213)
  call void @llvm.nvvm.barrier0()
  %218 = load float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), align 4
  %219 = fsub float %156, %218
  %220 = fmul float %219, 0x3FF7154760000000
  %221 = call float asm "ex2.approx.f32 $0, $1;", "=f,f"(float %220)
  call void @llvm.nvvm.barrier0()
  %222 = bitcast float %221 to i32
  %223 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %222, i32 16, i32 31)
  %224 = bitcast i32 %223 to float
  %225 = fadd float %221, %224
  %226 = bitcast float %225 to i32
  %227 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %226, i32 8, i32 31)
  %228 = bitcast i32 %227 to float
  %229 = fadd float %225, %228
  %230 = bitcast float %229 to i32
  %231 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %230, i32 4, i32 31)
  %232 = bitcast i32 %231 to float
  %233 = fadd float %229, %232
  %234 = bitcast float %233 to i32
  %235 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %234, i32 2, i32 31)
  %236 = bitcast i32 %235 to float
  %237 = fadd float %233, %236
  %238 = bitcast float %237 to i32
  %239 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %238, i32 1, i32 31)
  %240 = bitcast i32 %239 to float
  %241 = fadd float %237, %240
  %242 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %243 = udiv i32 %242, 32
  %244 = urem i32 %242, 32
  %245 = urem i32 %244, 32
  %246 = icmp eq i32 %245, 0
  %247 = urem i32 %243, 8
  %248 = getelementptr float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), i32 %247
  %249 = insertelement <1 x float> undef, float %241, i32 0
  %250 = extractelement <1 x float> %249, i32 0
  %251 = bitcast float %250 to i32
  %252 = insertelement <1 x i32> undef, i32 %251, i32 0
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %248, <1 x i32> %252, i1 %246)
  call void @llvm.nvvm.barrier0()
  %253 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %254 = urem i32 %253, 32
  %255 = icmp slt i32 %253, 8
  %256 = getelementptr float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), i32 %253
  %257 = call i32 asm sideeffect "@$2 ld.shared.b32 $0, [ $1 + 0 ];", "=r,r,b"(ptr addrspace(3) %256, i1 %255)
  %258 = insertelement <1 x i32> undef, i32 %257, i32 0
  %259 = extractelement <1 x i32> %258, i32 0
  %260 = bitcast i32 %259 to float
  %261 = insertelement <1 x float> undef, float %260, i32 0
  %262 = extractelement <1 x float> %261, i32 0
  %263 = bitcast float %262 to i32
  %264 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %263, i32 4, i32 31)
  %265 = bitcast i32 %264 to float
  %266 = fadd float %262, %265
  %267 = bitcast float %266 to i32
  %268 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %267, i32 2, i32 31)
  %269 = bitcast i32 %268 to float
  %270 = fadd float %266, %269
  %271 = bitcast float %270 to i32
  %272 = call i32 @llvm.nvvm.shfl.sync.bfly.i32(i32 -1, i32 %271, i32 1, i32 31)
  %273 = bitcast i32 %272 to float
  %274 = fadd float %270, %273
  %275 = getelementptr float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), i32 %253
  %276 = urem i32 %254, 8
  %277 = icmp eq i32 %276, 0
  %278 = and i1 %255, %277
  %279 = insertelement <1 x float> undef, float %274, i32 0
  %280 = extractelement <1 x float> %279, i32 0
  %281 = bitcast float %280 to i32
  %282 = insertelement <1 x i32> undef, i32 %281, i32 0
  call void asm sideeffect "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b"(ptr addrspace(3) %275, <1 x i32> %282, i1 %278)
  call void @llvm.nvvm.barrier0()
  %283 = load float, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @global_smem, i32 1024), align 4
  %284 = call float asm "div.full.f32 $0, $1, $2;", "=r,r,r"(float %221, float %283)
  %285 = mul i32 %102, %3
  %286 = getelementptr float, ptr addrspace(1) %0, i32 %285
  %287 = getelementptr float, ptr addrspace(1) %286, i32 %46
  %288 = insertelement <1 x float> undef, float %284, i32 0
  %289 = bitcast <1 x float> %288 to i32
  %290 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %291 = urem i32 %290, 32
  %292 = udiv i32 %290, 32
  %293 = and i32 0, %291
  %294 = icmp eq i32 %293, 0
  %295 = and i1 true, %294
  %296 = and i32 0, %292
  %297 = icmp eq i32 %296, 0
  %298 = and i1 %295, %297
  %299 = and i1 %298, %47
  call void asm sideeffect "@$2 st.global.b32 [ $1 + 0 ], { $0 };", "r,l,b"(i32 %289, ptr addrspace(1) %287, i1 %299)
  %300 = add i32 %103, 1
  %301 = icmp slt i32 %300, 1
  %302 = select i1 %301, i32 %300, i32 0
  %303 = add i32 %102, %9
  %304 = mul i32 %303, %2
  %305 = getelementptr float, ptr addrspace(1) %1, i32 %304
  %306 = getelementptr float, ptr addrspace(1) %305, i32 %46
  %307 = mul i32 %302, 256
  %308 = add i32 %307, 0
  %309 = add i32 %308, 0
  %310 = getelementptr float, ptr addrspace(3) @global_smem, i32 %309
  %311 = and i1 %108, %47
  %312 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %313 = urem i32 %312, 32
  %314 = udiv i32 %312, 32
  %315 = and i32 %313, 1
  %316 = icmp eq i32 %315, 0
  %317 = select i1 %316, i32 0, i32 1
  %318 = xor i32 0, %317
  %319 = and i32 %313, 2
  %320 = icmp eq i32 %319, 0
  %321 = select i1 %320, i32 0, i32 2
  %322 = xor i32 %318, %321
  %323 = and i32 %313, 4
  %324 = icmp eq i32 %323, 0
  %325 = select i1 %324, i32 0, i32 4
  %326 = xor i32 %322, %325
  %327 = and i32 %313, 8
  %328 = icmp eq i32 %327, 0
  %329 = select i1 %328, i32 0, i32 8
  %330 = xor i32 %326, %329
  %331 = and i32 %313, 16
  %332 = icmp eq i32 %331, 0
  %333 = select i1 %332, i32 0, i32 16
  %334 = xor i32 %330, %333
  %335 = and i32 %314, 1
  %336 = icmp eq i32 %335, 0
  %337 = select i1 %336, i32 0, i32 32
  %338 = xor i32 %334, %337
  %339 = and i32 %314, 2
  %340 = icmp eq i32 %339, 0
  %341 = select i1 %340, i32 0, i32 64
  %342 = xor i32 %338, %341
  %343 = and i32 %314, 4
  %344 = icmp eq i32 %343, 0
  %345 = select i1 %344, i32 0, i32 128
  %346 = xor i32 %342, %345
  %347 = mul i32 %346, 1
  %348 = add i32 %347, 0
  %349 = getelementptr inbounds float, ptr addrspace(3) %310, i32 %348
  %350 = select i1 %311, i32 4, i32 0
  %351 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %352 = urem i32 %351, 32
  %353 = udiv i32 %351, 32
  %354 = and i32 0, %352
  %355 = icmp eq i32 %354, 0
  %356 = and i1 true, %355
  %357 = and i32 0, %353
  %358 = icmp eq i32 %357, 0
  %359 = and i1 %356, %358
  call void asm sideeffect "@$3 cp.async.ca.shared.global [ $0 + 0 ], [ $1 + 0 ], 0x4, $2;", "r,l,r,b"(ptr addrspace(3) %349, ptr addrspace(1) %306, i32 %350, i1 %359)
  call void asm sideeffect "cp.async.commit_group ;", ""()
  %360 = add i32 %102, %9
  br label %101

361:                                              ; preds = %101
  call void asm sideeffect "cp.async.wait_group 0x0;", ""()
  call void @llvm.nvvm.barrier0()
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: convergent nocallback nounwind
declare void @llvm.nvvm.barrier0() #1

; Function Attrs: convergent nocallback nounwind memory(inaccessiblemem: readwrite)
declare i32 @llvm.nvvm.shfl.sync.bfly.i32(i32, i32, i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.maxnum.f32(float, float) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { convergent nocallback nounwind }
attributes #2 = { convergent nocallback nounwind memory(inaccessiblemem: readwrite) }

!llvm.module.flags = !{!0}
!nvvm.annotations = !{!1, !2}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{ptr @softmax_kernel, !"kernel", i32 1}
!2 = !{ptr @softmax_kernel, !"reqntidx", i32 256}
