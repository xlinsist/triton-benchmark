#!/bin/bash
set -e

# This script copies necessary build artifacts and scripts to the remote machine for execution.

# Get the directory of the current script.
DIR=$(dirname "$(readlink -f "$0")")

# Load global configuration.
if [ ! -f "${DIR}/global_config.sh" ]; then
  echo "Error: global_config.sh not found in ${DIR}"
  exit 1
fi
source "${DIR}/global_config.sh"

# Determine which compilers are enabled based on global config.
COMPILERS=()
if [ "$ENABLE_GCC" -eq 1 ]; then
  COMPILERS+=("gcc")
fi
if [ "$ENABLE_CLANG" -eq 1 ]; then
  COMPILERS+=("clang")
fi
if [ "$ENABLE_TRITON" -eq 1 ]; then
  COMPILERS+=("triton")
fi

if [ ${#COMPILERS[@]} -eq 0 ]; then
  echo "Warning: No compilers enabled in global_config.sh. Nothing to copy."
fi

# Convert benchmark and script lists into bash arrays.
IFS=' ' read -r -a BENCHMARKS <<< "$BENCHMARKS_LIST"
IFS=' ' read -r -a SCRIPTS <<< "$SCRIPTS_TO_COPY"

# Ensure remote base directory exists.
echo "Ensuring remote base directory exists at ${REMOTE_URL}:${REMOTE_BASE}"
ssh "${REMOTE_URL}" "mkdir -p ${REMOTE_BASE}"

# Copy the OpenMP sysroot for RISC-V platform.
echo "Copying openmp-sysroot-riscv to ${REMOTE_BASE}"
rsync -avz --ignore-existing \
  "${OPENMP_LIB_DIR}" \
  "${REMOTE_URL}:${REMOTE_BASE}"

# Copy compiled artifacts for each benchmark.
for BENCHMARK in "${BENCHMARKS[@]}"; do
  REMOTE_BIN_BASE="${REMOTE_BASE}/build-${BENCHMARK}/bin"
  LOCAL_BIN_DIR="${ROOT_DIR}/build-${BENCHMARK}/bin"

  echo "Cleaning remote benchmark directory ${REMOTE_URL}:${REMOTE_BIN_BASE}"
  ssh "${REMOTE_URL}" "rm -rf ${REMOTE_BIN_BASE}"

  for COMPILER in "${COMPILERS[@]}"; do
    # Path to the specific benchmark's compiled output for the current compiler.
    LOCAL_KERNEL_DIR="${LOCAL_BIN_DIR}/${COMPILER}/${BENCHMARK}"
    
    # Check if there are files to copy
    if ls "${LOCAL_KERNEL_DIR}"/*.{elf,cfg} >/dev/null 2>&1; then
      REMOTE_KERNEL_DIR_BASE="${REMOTE_BIN_BASE}/${COMPILER}"
      REMOTE_KERNEL_FULL_PATH="${REMOTE_KERNEL_DIR_BASE}/${BENCHMARK}"
      REMOTE_TARGET="${REMOTE_URL}:${REMOTE_KERNEL_DIR_BASE}/"
      
      echo "Copying artifacts for ${BENCHMARK} (${COMPILER}) to ${REMOTE_TARGET}"

      # Create remote directory and copy files.
      ssh "${REMOTE_URL}" "mkdir -p ${REMOTE_KERNEL_FULL_PATH}"
      scp -r "${LOCAL_KERNEL_DIR}"/*.{elf,cfg} "${REMOTE_URL}:${REMOTE_KERNEL_FULL_PATH}/"
    else
      echo "Warning: No .elf or .cfg files found in ${LOCAL_KERNEL_DIR}. Skipping copy for ${BENCHMARK} (${COMPILER})."
    fi
  done
done

# Copy utility scripts to the remote machine.
echo "Copying utility scripts to ${REMOTE_URL}:${REMOTE_BASE}/"
for SCRIPT in "${SCRIPTS[@]}"; do
    if [ -f "${ROOT_DIR}/scripts/${SCRIPT}" ]; then
        echo "  - Copying ${SCRIPT}"
        scp "${DIR}/${SCRIPT}" "${REMOTE_URL}:${REMOTE_BASE}/"
    else
        echo "Warning: Script '${SCRIPT}' not found, cannot copy to remote."
    fi
done

echo "All files processed."
