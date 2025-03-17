# MLIR Compilation and Simulation

## Prerequisite
Noted that the testcase will only work if you have already applied the patch llvm-0001, llvm-0002, and llvm-0003 at examples/patch/ventus/.

```bash
export VENTUS_INSTALL_PREFIX=/path-to(CHANGE IT!)/llvm-project/install
export PATH=${VENTUS_INSTALL_PREFIX}/bin:$PATH
export SPIKE_SRC_DIR=/path-to(CHANGE IT!)/ventus-gpgpu-isa-simulator
export SPIKE_TARGET_DIR=${VENTUS_INSTALL_PREFIX}
export LD_LIBRARY_PATH=$SPIKE_TARGET_DIR/lib:$LD_LIBRARY_PATH
```

## Compilation & Simulation

Take `backprop.mlir` as the testcase.

```bash
cd /path-to(CHANGE IT!)/examples/ventus/backprop
make get-backprop-riscv # mlir to riscv binary
make objdump # riscv binary dump
make pass-to-driver # pass the test and binary file to ventus spike driver
make run-backprop-riscv # run the test case in driver
```

The expected terminal result:  
```
=== dW Output (4x4 Matrix) ===  
001.00 000.00 000.00 000.00   
000.00 006.00 000.00 000.00   
000.00 000.00 011.00 000.00   
000.00 000.00 000.00 016.00 
```
