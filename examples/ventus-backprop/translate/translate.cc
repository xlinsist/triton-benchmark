#include "mlir/IR/AsmState.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OwningOpRef.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlow.h"
#include "mlir/Target/LLVMIR/ModuleTranslation.h"
#include "mlir/Target/LLVMIR/LLVMTranslationInterface.h"
#include "mlir/Target/LLVMIR/Dialect/LLVMIR/LLVMToLLVMIRTranslation.h"
#include "mlir/Dialect/DLTI/DLTI.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"

#include "llvm/IR/LLVMContext.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/CodeGen.h"
#include "llvm/Support/CommandLine.h"

#include <optional>
#include <iostream>
#include <fstream>

#define LLVM_IDENT "clang version 16.0.0 (https://github.com/THU-DSP-LAB/llvm-project.git 0f31d6ca085de0b69ab06e00b0add1cbe1b2b7ed)"

void save_llvm_module(const std::unique_ptr<llvm::Module>& self, std::string filename) {
    std::string str;
    llvm::raw_string_ostream os(str);
    os << *self;

    std::ofstream file(filename);
    file<<os.str()<<"\n";
}

int main(int argc, char *argv[]) {
    std::string in_filename = argv[1];

    mlir::MLIRContext mlir_ctx = mlir::MLIRContext();

    mlir_ctx.getOrLoadDialect<mlir::LLVM::LLVMDialect>();
    mlir_ctx.getOrLoadDialect<mlir::DLTIDialect>();
    mlir::registerLLVMDialectTranslation(mlir_ctx);
    
    mlir::OwningOpRef<mlir::ModuleOp> mlir_module = mlir::parseSourceFile<mlir::ModuleOp>(in_filename, &mlir_ctx);
    if (!mlir_module)
        throw std::runtime_error("Parse MLIR file failed.");
    // 将文件中的 MLIR 转换为内存表示 mlir::ModuleOp

    std::vector<llvm::StringRef> kernel_func_names;
    for (mlir::LLVM::LLVMFuncOp func_op : mlir_module->getOps<mlir::LLVM::LLVMFuncOp>()) {
        bool ventus_kernel_flag = false;
        if (auto callConv = func_op->getAttrOfType<mlir::LLVM::CConvAttr>("CConv")) {
            if (auto ventus_kernel_cconv = mlir::LLVM::cconv::symbolizeCConv("ventus_kernelcc"))
                ventus_kernel_flag = callConv.getCallingConv()==ventus_kernel_cconv.value();
        } // 此步是用于确定该函数是否为 ventus_kernel 函数
        if (ventus_kernel_flag)
            kernel_func_names.push_back(func_op.getName());
    }
    // 获取所有的非定义的函数名称(即核函数), 后续在 LLVM IR, 我们会为这些函数添加属性和调用约定

    static std::once_flag init_flag;
    std::call_once(init_flag, []() {
        LLVMInitializeRISCVTargetInfo();
        LLVMInitializeRISCVTarget();
        LLVMInitializeRISCVTargetMC();
        LLVMInitializeRISCVAsmParser();
        LLVMInitializeRISCVAsmPrinter();
    });
    
    llvm::LLVMContext llvm_ctx = llvm::LLVMContext();
    std::unique_ptr<llvm::Module> llvm_module = mlir::translateModuleToLLVMIR(mlir_module->clone(), llvm_ctx);
    // 将 MLIR 转换为 LLVM IR

    std::string triple = "riscv32-unknown-linux-gnu";
    std::string proc = "generic";
    std::string features = "";

    std::string error;
    auto target = llvm::TargetRegistry::lookupTarget(triple, error);
    if (!target)
        throw std::runtime_error("target lookup error: " + error);

    llvm::TargetOptions opt;
    auto RM = std::optional<llvm::Reloc::Model>();

    std::unique_ptr<llvm::TargetMachine> machine{
        target->createTargetMachine(
            triple, proc, features, opt, RM
        )
    };

    llvm_module->setDataLayout(machine->createDataLayout());
    llvm_module->setTargetTriple("riscv32");

    llvm::Function* malloc_func = llvm_module->getFunction("malloc");
    llvm::Function* free_func = llvm_module->getFunction("free");
    malloc_func->eraseFromParent();
    free_func->eraseFromParent();
    // 删除 malloc 和 free 函数, 这在 MLIR -> LLVM IR 阶段会自动加入, 不知道为什么

    for (llvm::StringRef kernel_func_name : kernel_func_names) {
        llvm::Function* kernel_func = llvm_module->getFunction(kernel_func_name);

        kernel_func->setCallingConv(llvm::CallingConv::VENTUS_KERNEL);
        kernel_func->addFnAttr(llvm::Attribute::NoUnwind);
    }
    // 给每个核函数添加调用约定和函数属性

    auto llvm_ident = llvm::MDNode::get(
        llvm_ctx,
        llvm::MDString::get(llvm_ctx, LLVM_IDENT)
    );

    llvm_module->getModuleFlagsMetadata()->eraseFromParent();

    llvm_module
        ->getOrInsertNamedMetadata("llvm.ident")
        ->addOperand(llvm_ident);
    // 给 LLVM IR 添加元信息

    std::string out_filename = argv[2];
    save_llvm_module(llvm_module, out_filename);

    return 0;
}
