module attributes {"triton_gpu.num-ctas" = 1 : i32, "triton_gpu.num-warps" = 8 : i32, triton_gpu.shared = 32 : i32, triton_gpu.target = "cuda:61", "triton_gpu.threads-per-warp" = 32 : i32} {
  llvm.mlir.global external @global_smem() {addr_space = 3 : i32, alignment = 16 : i64} : !llvm.array<0 x i8>
  llvm.func @softmax_kernel(%arg0: !llvm.ptr<1> {tt.divisibility = 16 : i32}, %arg1: !llvm.ptr<1> {tt.divisibility = 16 : i32}, %arg2: i32 {tt.divisibility = 16 : i32}, %arg3: i32 {tt.divisibility = 16 : i32}, %arg4: i32 {tt.divisibility = 16 : i32}, %arg5: i32 {tt.divisibility = 16 : i32}) attributes {noinline = false, nvvm.kernel = 1 : ui1, nvvm.maxntid = array<i32: 256>} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1.44269502 : f32) : f32
    %2 = llvm.mlir.addressof @global_smem : !llvm.ptr<3>
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(31 : i32) : i32
    %5 = llvm.mlir.constant(1024 : i32) : i32
    %6 = llvm.mlir.constant(512 : i32) : i32
    %7 = llvm.mlir.constant(256 : i32) : i32
    %8 = llvm.mlir.constant(128 : i32) : i32
    %9 = llvm.mlir.constant(64 : i32) : i32
    %10 = llvm.mlir.constant(16 : i32) : i32
    %11 = llvm.mlir.constant(8 : i32) : i32
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(4 : i32) : i32
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.mlir.constant(32 : i32) : i32
    %17 = llvm.mlir.constant(0 : index) : i32
    %18 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %19 = llvm.inline_asm asm_dialect = att operand_attrs = [] "mov.u32 $0, %ctaid.x;", "=r"  : () -> i32
    %20 = llvm.inline_asm asm_dialect = att operand_attrs = [] "mov.u32 $0, %nctaid.x;", "=r"  : () -> i32
    %21 = nvvm.read.ptx.sreg.tid.x : i32
    %22 = llvm.urem %21, %16  : i32
    %23 = llvm.udiv %21, %16  : i32
    %24 = llvm.and %22, %14  : i32
    %25 = llvm.icmp "eq" %24, %15 : i32
    %26 = llvm.select %25, %15, %13 : i1, i32
    %27 = llvm.xor %15, %26  : i32
    %28 = llvm.and %22, %12  : i32
    %29 = llvm.icmp "eq" %28, %15 : i32
    %30 = llvm.select %29, %15, %11 : i1, i32
    %31 = llvm.xor %27, %30  : i32
    %32 = llvm.and %22, %13  : i32
    %33 = llvm.icmp "eq" %32, %15 : i32
    %34 = llvm.select %33, %15, %10 : i1, i32
    %35 = llvm.xor %31, %34  : i32
    %36 = llvm.and %22, %11  : i32
    %37 = llvm.icmp "eq" %36, %15 : i32
    %38 = llvm.select %37, %15, %16 : i1, i32
    %39 = llvm.xor %35, %38  : i32
    %40 = llvm.and %22, %10  : i32
    %41 = llvm.icmp "eq" %40, %15 : i32
    %42 = llvm.select %41, %15, %9 : i1, i32
    %43 = llvm.xor %39, %42  : i32
    %44 = llvm.and %23, %14  : i32
    %45 = llvm.icmp "eq" %44, %15 : i32
    %46 = llvm.select %45, %15, %8 : i1, i32
    %47 = llvm.xor %43, %46  : i32
    %48 = llvm.and %23, %12  : i32
    %49 = llvm.icmp "eq" %48, %15 : i32
    %50 = llvm.select %49, %15, %7 : i1, i32
    %51 = llvm.xor %47, %50  : i32
    %52 = llvm.and %23, %13  : i32
    %53 = llvm.icmp "eq" %52, %15 : i32
    %54 = llvm.select %53, %15, %6 : i1, i32
    %55 = llvm.xor %51, %54  : i32
    %56 = llvm.and %22, %14  : i32
    %57 = llvm.icmp "eq" %56, %15 : i32
    %58 = llvm.select %57, %15, %13 : i1, i32
    %59 = llvm.xor %5, %58  : i32
    %60 = llvm.and %22, %12  : i32
    %61 = llvm.icmp "eq" %60, %15 : i32
    %62 = llvm.select %61, %15, %11 : i1, i32
    %63 = llvm.xor %59, %62  : i32
    %64 = llvm.and %22, %13  : i32
    %65 = llvm.icmp "eq" %64, %15 : i32
    %66 = llvm.select %65, %15, %10 : i1, i32
    %67 = llvm.xor %63, %66  : i32
    %68 = llvm.and %22, %11  : i32
    %69 = llvm.icmp "eq" %68, %15 : i32
    %70 = llvm.select %69, %15, %16 : i1, i32
    %71 = llvm.xor %67, %70  : i32
    %72 = llvm.and %22, %10  : i32
    %73 = llvm.icmp "eq" %72, %15 : i32
    %74 = llvm.select %73, %15, %9 : i1, i32
    %75 = llvm.xor %71, %74  : i32
    %76 = llvm.and %23, %14  : i32
    %77 = llvm.icmp "eq" %76, %15 : i32
    %78 = llvm.select %77, %15, %8 : i1, i32
    %79 = llvm.xor %75, %78  : i32
    %80 = llvm.and %23, %12  : i32
    %81 = llvm.icmp "eq" %80, %15 : i32
    %82 = llvm.select %81, %15, %7 : i1, i32
    %83 = llvm.xor %79, %82  : i32
    %84 = llvm.and %23, %13  : i32
    %85 = llvm.icmp "eq" %84, %15 : i32
    %86 = llvm.select %85, %15, %6 : i1, i32
    %87 = llvm.xor %83, %86  : i32
    %88 = llvm.add %55, %17 : i32
    %89 = llvm.add %87, %17 : i32
    %90 = llvm.icmp "slt" %88, %arg5 : i32
    %91 = llvm.icmp "slt" %89, %arg5 : i32
    llvm.br ^bb1(%19 : i32)
  ^bb1(%92: i32):  // 2 preds: ^bb0, ^bb2
    %93 = llvm.icmp "slt" %92, %arg4 : i32
    llvm.cond_br %93, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %94 = llvm.mul %92, %arg2 : i32
    %95 = llvm.getelementptr %arg1[%94] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %96 = llvm.getelementptr %95[%88] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %97 = llvm.getelementptr %95[%89] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %98 = llvm.mlir.undef : vector<1xf32>
    %99 = llvm.insertelement %18, %98[%17 : i32] : vector<1xf32>
    %100 = llvm.bitcast %99 : vector<1xf32> to i32
    %101 = llvm.mlir.undef : vector<1xf32>
    %102 = llvm.insertelement %18, %101[%17 : i32] : vector<1xf32>
    %103 = llvm.bitcast %102 : vector<1xf32> to i32
    %104 = llvm.mlir.undef : vector<1xf32>
    %105 = llvm.insertelement %18, %104[%17 : i32] : vector<1xf32>
    %106 = llvm.bitcast %105 : vector<1xf32> to i32
    %107 = llvm.mlir.undef : vector<1xf32>
    %108 = llvm.insertelement %18, %107[%17 : i32] : vector<1xf32>
    %109 = llvm.bitcast %108 : vector<1xf32> to i32
    %110 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];\0A\09@!$7 mov.u32 $0, $6;\0A\09@!$9 mov.u32 $1, $8;\0A\09@!$11 mov.u32 $2, $10;\0A\09@!$13 mov.u32 $3, $12;", "=r,=r,=r,=r,l,b,r,b,r,b,r,b,r,b" %96, %90, %100, %90, %103, %90, %106, %90, %109, %90 : (!llvm.ptr<1>, i1, i32, i1, i32, i1, i32, i1, i32, i1) -> !llvm.struct<(i32, i32, i32, i32)>
    %111 = llvm.extractvalue %110[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %112 = llvm.bitcast %111 : i32 to vector<1xf32>
    %113 = llvm.extractvalue %110[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %114 = llvm.bitcast %113 : i32 to vector<1xf32>
    %115 = llvm.extractvalue %110[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %116 = llvm.bitcast %115 : i32 to vector<1xf32>
    %117 = llvm.extractvalue %110[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %118 = llvm.bitcast %117 : i32 to vector<1xf32>
    %119 = llvm.extractelement %112[%17 : i32] : vector<1xf32>
    %120 = llvm.extractelement %114[%17 : i32] : vector<1xf32>
    %121 = llvm.extractelement %116[%17 : i32] : vector<1xf32>
    %122 = llvm.extractelement %118[%17 : i32] : vector<1xf32>
    %123 = llvm.mlir.undef : vector<1xf32>
    %124 = llvm.insertelement %18, %123[%17 : i32] : vector<1xf32>
    %125 = llvm.bitcast %124 : vector<1xf32> to i32
    %126 = llvm.mlir.undef : vector<1xf32>
    %127 = llvm.insertelement %18, %126[%17 : i32] : vector<1xf32>
    %128 = llvm.bitcast %127 : vector<1xf32> to i32
    %129 = llvm.mlir.undef : vector<1xf32>
    %130 = llvm.insertelement %18, %129[%17 : i32] : vector<1xf32>
    %131 = llvm.bitcast %130 : vector<1xf32> to i32
    %132 = llvm.mlir.undef : vector<1xf32>
    %133 = llvm.insertelement %18, %132[%17 : i32] : vector<1xf32>
    %134 = llvm.bitcast %133 : vector<1xf32> to i32
    %135 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09@$5 ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];\0A\09@!$7 mov.u32 $0, $6;\0A\09@!$9 mov.u32 $1, $8;\0A\09@!$11 mov.u32 $2, $10;\0A\09@!$13 mov.u32 $3, $12;", "=r,=r,=r,=r,l,b,r,b,r,b,r,b,r,b" %97, %91, %125, %91, %128, %91, %131, %91, %134, %91 : (!llvm.ptr<1>, i1, i32, i1, i32, i1, i32, i1, i32, i1) -> !llvm.struct<(i32, i32, i32, i32)>
    %136 = llvm.extractvalue %135[0] : !llvm.struct<(i32, i32, i32, i32)> 
    %137 = llvm.bitcast %136 : i32 to vector<1xf32>
    %138 = llvm.extractvalue %135[1] : !llvm.struct<(i32, i32, i32, i32)> 
    %139 = llvm.bitcast %138 : i32 to vector<1xf32>
    %140 = llvm.extractvalue %135[2] : !llvm.struct<(i32, i32, i32, i32)> 
    %141 = llvm.bitcast %140 : i32 to vector<1xf32>
    %142 = llvm.extractvalue %135[3] : !llvm.struct<(i32, i32, i32, i32)> 
    %143 = llvm.bitcast %142 : i32 to vector<1xf32>
    %144 = llvm.extractelement %137[%17 : i32] : vector<1xf32>
    %145 = llvm.extractelement %139[%17 : i32] : vector<1xf32>
    %146 = llvm.extractelement %141[%17 : i32] : vector<1xf32>
    %147 = llvm.extractelement %143[%17 : i32] : vector<1xf32>
    nvvm.barrier0
    %148 = llvm.intr.maxnum(%119, %120)  : (f32, f32) -> f32
    %149 = llvm.intr.maxnum(%148, %121)  : (f32, f32) -> f32
    %150 = llvm.intr.maxnum(%149, %122)  : (f32, f32) -> f32
    %151 = llvm.intr.maxnum(%150, %144)  : (f32, f32) -> f32
    %152 = llvm.intr.maxnum(%151, %145)  : (f32, f32) -> f32
    %153 = llvm.intr.maxnum(%152, %146)  : (f32, f32) -> f32
    %154 = llvm.intr.maxnum(%153, %147)  : (f32, f32) -> f32
    %155 = llvm.bitcast %154 : f32 to i32
    %156 = nvvm.shfl.sync  bfly %3, %155, %10, %4 : i32 -> i32
    %157 = llvm.bitcast %156 : i32 to f32
    %158 = llvm.intr.maxnum(%154, %157)  : (f32, f32) -> f32
    %159 = llvm.bitcast %158 : f32 to i32
    %160 = nvvm.shfl.sync  bfly %3, %159, %11, %4 : i32 -> i32
    %161 = llvm.bitcast %160 : i32 to f32
    %162 = llvm.intr.maxnum(%158, %161)  : (f32, f32) -> f32
    %163 = llvm.bitcast %162 : f32 to i32
    %164 = nvvm.shfl.sync  bfly %3, %163, %13, %4 : i32 -> i32
    %165 = llvm.bitcast %164 : i32 to f32
    %166 = llvm.intr.maxnum(%162, %165)  : (f32, f32) -> f32
    %167 = llvm.bitcast %166 : f32 to i32
    %168 = nvvm.shfl.sync  bfly %3, %167, %12, %4 : i32 -> i32
    %169 = llvm.bitcast %168 : i32 to f32
    %170 = llvm.intr.maxnum(%166, %169)  : (f32, f32) -> f32
    %171 = llvm.bitcast %170 : f32 to i32
    %172 = nvvm.shfl.sync  bfly %3, %171, %14, %4 : i32 -> i32
    %173 = llvm.bitcast %172 : i32 to f32
    %174 = llvm.intr.maxnum(%170, %173)  : (f32, f32) -> f32
    %175 = nvvm.read.ptx.sreg.tid.x : i32
    %176 = llvm.udiv %175, %16  : i32
    %177 = llvm.urem %175, %16  : i32
    %178 = llvm.urem %177, %16  : i32
    %179 = llvm.icmp "eq" %178, %15 : i32
    %180 = llvm.urem %176, %11  : i32
    %181 = llvm.getelementptr %2[%180] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %182 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b" %181, %174, %179 : (!llvm.ptr<3>, f32, i1) -> !llvm.void
    nvvm.barrier0
    %183 = nvvm.read.ptx.sreg.tid.x : i32
    %184 = llvm.urem %183, %16  : i32
    %185 = llvm.icmp "slt" %183, %11 : i32
    %186 = llvm.getelementptr %2[%183] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %187 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$2 ld.shared.b32 $0, [ $1 + 0 ];", "=r,r,b" %186, %185 : (!llvm.ptr<3>, i1) -> f32
    %188 = llvm.bitcast %187 : f32 to i32
    %189 = nvvm.shfl.sync  bfly %3, %188, %13, %4 : i32 -> i32
    %190 = llvm.bitcast %189 : i32 to f32
    %191 = llvm.intr.maxnum(%187, %190)  : (f32, f32) -> f32
    %192 = llvm.bitcast %191 : f32 to i32
    %193 = nvvm.shfl.sync  bfly %3, %192, %12, %4 : i32 -> i32
    %194 = llvm.bitcast %193 : i32 to f32
    %195 = llvm.intr.maxnum(%191, %194)  : (f32, f32) -> f32
    %196 = llvm.bitcast %195 : f32 to i32
    %197 = nvvm.shfl.sync  bfly %3, %196, %14, %4 : i32 -> i32
    %198 = llvm.bitcast %197 : i32 to f32
    %199 = llvm.intr.maxnum(%195, %198)  : (f32, f32) -> f32
    %200 = llvm.getelementptr %2[%183] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %201 = llvm.urem %184, %11  : i32
    %202 = llvm.icmp "eq" %201, %15 : i32
    %203 = llvm.and %185, %202  : i1
    %204 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b" %200, %199, %203 : (!llvm.ptr<3>, f32, i1) -> !llvm.void
    nvvm.barrier0
    %205 = llvm.load %2 : !llvm.ptr<3> -> f32
    %206 = llvm.fsub %119, %205  : f32
    %207 = llvm.fsub %120, %205  : f32
    %208 = llvm.fsub %121, %205  : f32
    %209 = llvm.fsub %122, %205  : f32
    %210 = llvm.fsub %144, %205  : f32
    %211 = llvm.fsub %145, %205  : f32
    %212 = llvm.fsub %146, %205  : f32
    %213 = llvm.fsub %147, %205  : f32
    %214 = llvm.fmul %206, %1  : f32
    %215 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %214 : (f32) -> f32
    %216 = llvm.fmul %207, %1  : f32
    %217 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %216 : (f32) -> f32
    %218 = llvm.fmul %208, %1  : f32
    %219 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %218 : (f32) -> f32
    %220 = llvm.fmul %209, %1  : f32
    %221 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %220 : (f32) -> f32
    %222 = llvm.fmul %210, %1  : f32
    %223 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %222 : (f32) -> f32
    %224 = llvm.fmul %211, %1  : f32
    %225 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %224 : (f32) -> f32
    %226 = llvm.fmul %212, %1  : f32
    %227 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %226 : (f32) -> f32
    %228 = llvm.fmul %213, %1  : f32
    %229 = llvm.inline_asm asm_dialect = att operand_attrs = [] "ex2.approx.f32 $0, $1;", "=f,f" %228 : (f32) -> f32
    nvvm.barrier0
    %230 = llvm.fadd %215, %217  : f32
    %231 = llvm.fadd %230, %219  : f32
    %232 = llvm.fadd %231, %221  : f32
    %233 = llvm.fadd %232, %223  : f32
    %234 = llvm.fadd %233, %225  : f32
    %235 = llvm.fadd %234, %227  : f32
    %236 = llvm.fadd %235, %229  : f32
    %237 = llvm.bitcast %236 : f32 to i32
    %238 = nvvm.shfl.sync  bfly %3, %237, %10, %4 : i32 -> i32
    %239 = llvm.bitcast %238 : i32 to f32
    %240 = llvm.fadd %236, %239  : f32
    %241 = llvm.bitcast %240 : f32 to i32
    %242 = nvvm.shfl.sync  bfly %3, %241, %11, %4 : i32 -> i32
    %243 = llvm.bitcast %242 : i32 to f32
    %244 = llvm.fadd %240, %243  : f32
    %245 = llvm.bitcast %244 : f32 to i32
    %246 = nvvm.shfl.sync  bfly %3, %245, %13, %4 : i32 -> i32
    %247 = llvm.bitcast %246 : i32 to f32
    %248 = llvm.fadd %244, %247  : f32
    %249 = llvm.bitcast %248 : f32 to i32
    %250 = nvvm.shfl.sync  bfly %3, %249, %12, %4 : i32 -> i32
    %251 = llvm.bitcast %250 : i32 to f32
    %252 = llvm.fadd %248, %251  : f32
    %253 = llvm.bitcast %252 : f32 to i32
    %254 = nvvm.shfl.sync  bfly %3, %253, %14, %4 : i32 -> i32
    %255 = llvm.bitcast %254 : i32 to f32
    %256 = llvm.fadd %252, %255  : f32
    %257 = nvvm.read.ptx.sreg.tid.x : i32
    %258 = llvm.udiv %257, %16  : i32
    %259 = llvm.urem %257, %16  : i32
    %260 = llvm.urem %259, %16  : i32
    %261 = llvm.icmp "eq" %260, %15 : i32
    %262 = llvm.urem %258, %11  : i32
    %263 = llvm.getelementptr %2[%262] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %264 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b" %263, %256, %261 : (!llvm.ptr<3>, f32, i1) -> !llvm.void
    nvvm.barrier0
    %265 = nvvm.read.ptx.sreg.tid.x : i32
    %266 = llvm.urem %265, %16  : i32
    %267 = llvm.icmp "slt" %265, %11 : i32
    %268 = llvm.getelementptr %2[%265] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %269 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$2 ld.shared.b32 $0, [ $1 + 0 ];", "=r,r,b" %268, %267 : (!llvm.ptr<3>, i1) -> f32
    %270 = llvm.bitcast %269 : f32 to i32
    %271 = nvvm.shfl.sync  bfly %3, %270, %13, %4 : i32 -> i32
    %272 = llvm.bitcast %271 : i32 to f32
    %273 = llvm.fadd %269, %272  : f32
    %274 = llvm.bitcast %273 : f32 to i32
    %275 = nvvm.shfl.sync  bfly %3, %274, %12, %4 : i32 -> i32
    %276 = llvm.bitcast %275 : i32 to f32
    %277 = llvm.fadd %273, %276  : f32
    %278 = llvm.bitcast %277 : f32 to i32
    %279 = nvvm.shfl.sync  bfly %3, %278, %14, %4 : i32 -> i32
    %280 = llvm.bitcast %279 : i32 to f32
    %281 = llvm.fadd %277, %280  : f32
    %282 = llvm.getelementptr %2[%265] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
    %283 = llvm.urem %266, %11  : i32
    %284 = llvm.icmp "eq" %283, %15 : i32
    %285 = llvm.and %267, %284  : i1
    %286 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$2 st.shared.b32 [ $0 + 0 ], $1;", "r,r,b" %282, %281, %285 : (!llvm.ptr<3>, f32, i1) -> !llvm.void
    nvvm.barrier0
    %287 = llvm.load %2 : !llvm.ptr<3> -> f32
    %288 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %215, %287 : (f32, f32) -> f32
    %289 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %217, %287 : (f32, f32) -> f32
    %290 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %219, %287 : (f32, f32) -> f32
    %291 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %221, %287 : (f32, f32) -> f32
    %292 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %223, %287 : (f32, f32) -> f32
    %293 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %225, %287 : (f32, f32) -> f32
    %294 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %227, %287 : (f32, f32) -> f32
    %295 = llvm.inline_asm asm_dialect = att operand_attrs = [] "div.full.f32 $0, $1, $2;", "=r,r,r" %229, %287 : (f32, f32) -> f32
    %296 = llvm.mul %92, %arg3 : i32
    %297 = llvm.getelementptr %arg0[%296] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %298 = llvm.getelementptr %297[%88] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %299 = llvm.getelementptr %297[%89] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %300 = llvm.mlir.undef : vector<1xf32>
    %301 = llvm.insertelement %288, %300[%15 : i32] : vector<1xf32>
    %302 = llvm.bitcast %301 : vector<1xf32> to i32
    %303 = llvm.mlir.undef : vector<1xf32>
    %304 = llvm.insertelement %289, %303[%15 : i32] : vector<1xf32>
    %305 = llvm.bitcast %304 : vector<1xf32> to i32
    %306 = llvm.mlir.undef : vector<1xf32>
    %307 = llvm.insertelement %290, %306[%15 : i32] : vector<1xf32>
    %308 = llvm.bitcast %307 : vector<1xf32> to i32
    %309 = llvm.mlir.undef : vector<1xf32>
    %310 = llvm.insertelement %291, %309[%15 : i32] : vector<1xf32>
    %311 = llvm.bitcast %310 : vector<1xf32> to i32
    %312 = llvm.and %0, %90  : i1
    %313 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b" %302, %305, %308, %311, %298, %312 : (i32, i32, i32, i32, !llvm.ptr<1>, i1) -> !llvm.void
    %314 = llvm.mlir.undef : vector<1xf32>
    %315 = llvm.insertelement %292, %314[%15 : i32] : vector<1xf32>
    %316 = llvm.bitcast %315 : vector<1xf32> to i32
    %317 = llvm.mlir.undef : vector<1xf32>
    %318 = llvm.insertelement %293, %317[%15 : i32] : vector<1xf32>
    %319 = llvm.bitcast %318 : vector<1xf32> to i32
    %320 = llvm.mlir.undef : vector<1xf32>
    %321 = llvm.insertelement %294, %320[%15 : i32] : vector<1xf32>
    %322 = llvm.bitcast %321 : vector<1xf32> to i32
    %323 = llvm.mlir.undef : vector<1xf32>
    %324 = llvm.insertelement %295, %323[%15 : i32] : vector<1xf32>
    %325 = llvm.bitcast %324 : vector<1xf32> to i32
    %326 = llvm.and %0, %91  : i1
    %327 = llvm.inline_asm has_side_effects asm_dialect = att operand_attrs = [] "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b" %316, %319, %322, %325, %299, %326 : (i32, i32, i32, i32, !llvm.ptr<1>, i1) -> !llvm.void
    %328 = llvm.add %92, %20 : i32
    llvm.br ^bb1(%328 : i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}

