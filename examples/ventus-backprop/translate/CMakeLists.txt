cmake_minimum_required(VERSION 3.10)
project(Translate)

# set(LLVM_BUILD /root/gpgpu/llvm-project/build)
set(LLVM_BUILD $ENV{LLVM_BUILD})

set(LLVM_DIR ${LLVM_BUILD}/lib/cmake/llvm)
set(MLIR_DIR ${LLVM_BUILD}/lib/cmake/mlir)
find_package(MLIR REQUIRED CONFIG)
find_package(LLVM REQUIRED CONFIG)

include_directories(
    ${LLVM_BUILD}/../build/include
    ${LLVM_BUILD}/../build/tools/mlir/include
    ${LLVM_BUILD}/../mlir/include
    ${LLVM_BUILD}/../llvm/include
)

add_executable(translate translate.cc)
target_link_libraries(translate
    PRIVATE

    MLIRGPUToGPURuntimeTransforms
    MLIRGPUTransforms
    MLIRIR
    MLIRControlFlowToLLVM
    MLIRBytecodeWriter
    MLIRPass
    MLIRTransforms
    MLIRLLVMDialect
    MLIRSupport
    MLIRTargetLLVMIRExport
    MLIRMathToLLVM
    MLIRSCFToControlFlow
    MLIRIndexToLLVM
    
    LLVMCore
    LLVMSupport
    LLVMAnalysis

    LLVMRISCVCodeGen
    LLVMRISCVDesc
    LLVMRISCVInfo
    LLVMRISCVAsmParser
    LLVMRISCVDisassembler
)
