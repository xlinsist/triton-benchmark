#include "ventus.h"
#include <iostream>
#include <iomanip>
using namespace std;

#ifndef KERNEL_ADDRESS
#define KERNEL_ADDRESS  0x800000b8  
#endif

struct meta_data {
    uint64_t kernel_id;
    uint64_t kernel_size[3];
    uint64_t wf_size;
    uint64_t wg_size;
    uint64_t metaDataBaseAddr;
    uint64_t ldsSize;
    uint64_t pdsSize;
    uint64_t sgprUsage;
    uint64_t vgprUsage;
    uint64_t pdsBaseAddr;
    meta_data(uint64_t arg0, uint64_t arg1[], uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
              uint64_t arg6, uint64_t arg7, uint64_t arg8, uint64_t arg9)
        : kernel_id(arg0), wf_size(arg2), wg_size(arg3), metaDataBaseAddr(arg4), ldsSize(arg5), pdsSize(arg6),
          sgprUsage(arg7), vgprUsage(arg8), pdsBaseAddr(arg9) {
        kernel_size[0] = arg1[0];
        kernel_size[1] = arg1[1];
        kernel_size[2] = arg1[2];
    }
};

int main() {
    uint64_t num_warp = 4;
    uint64_t num_thread = 16;
    uint64_t num_workgroups[3] = {1, 1, 1};
    uint64_t num_workgroup = num_workgroups[0] * num_workgroups[1] * num_workgroups[2];
    uint64_t num_processor = num_warp * num_workgroup;
    uint64_t ldssize = 0x1000;
    uint64_t pdssize = 0x1000;
    uint64_t pdsbase = 0x8a000000;
    uint64_t start_pc = 0x80000000;
    uint64_t knlbase = 0x90000000;
    meta_data meta(0, num_workgroups, num_thread, num_warp, knlbase, ldssize, pdssize, 32, 32, pdsbase);
    char filename[] = "backprop.riscv";

    // 1D 数据
    uint64_t size_0 = 0x10000000;
    float data_0[16] = {
        1, 2, 3, 4, 
        5, 6, 7, 8,
        9, 10, 11, 12,
        13, 14, 15, 16
    };  // arg_1 (dY)
    uint64_t vaddr_0;

    uint64_t size_1 = 0x10000000;
    float data_1[16] = {
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
    };  // arg_2 (A)
    uint64_t vaddr_1, vaddr_2, vaddr_3, vaddr_4;

    uint64_t vaddr_print;
    uint64_t size_print = 0x10000000;

    vt_device_h p = nullptr;
    vt_dev_open(&p);

    vt_buf_alloc(p, size_0, &vaddr_0, 0, 0, 0);  // 分配程序空间
    vt_buf_alloc(p, pdssize * num_thread * num_warp * num_workgroup, &pdsbase, 0, 0, 0);  // 分配私有内存
    vt_buf_alloc(p, 16 * 4, &vaddr_1, 0, 0, 0);  // 分配 dY 缓冲区
    vt_buf_alloc(p, 16 * 4, &vaddr_2, 0, 0, 0);  // 分配 A 缓冲区
    vt_buf_alloc(p, 16 * 4, &vaddr_3, 0, 0, 0);  // 分配 dW 缓冲区
    vt_buf_alloc(p, 2 * 4, &vaddr_4, 0, 0, 0);   // 分配参数基地址缓冲区

    vt_buf_alloc(p, size_print, &vaddr_print, 0, 0, 0);  // 分配打印缓冲区

    // 复制数据到设备
    vt_copy_to_dev(p, vaddr_1, data_0, 16 * 4, 0, 0);  // 传输 dY
    vt_copy_to_dev(p, vaddr_2, data_1, 16 * 4, 0, 0);  // 传输 A

    meta.metaDataBaseAddr = vaddr_3;
    meta.pdsBaseAddr = pdsbase;

    // 设置 metadata
    uint32_t data_2[14] = {0};  // Metadata
    data_2[0] = KERNEL_ADDRESS;
    data_2[1] = (uint32_t)vaddr_4;
    data_2[2] = meta.kernel_size[0];
    data_2[6] = num_thread;
    data_2[9] = 0;
    data_2[10] = 0;
    data_2[11] = 0;
    data_2[12] = (uint32_t)vaddr_print;
    data_2[13] = (uint32_t)size_print;

    vt_copy_to_dev(p, vaddr_3, data_2, 14 * 4, 0, 0);

    // 设置 buffer base
    uint32_t data_3[3] = {(uint32_t)vaddr_1, (uint32_t)vaddr_2, (uint32_t)vaddr_3};  // dY, A, dW
    vt_copy_to_dev(p, vaddr_4, data_3, 3 * 4, 0, 0);

    // 上传并启动 kernel
    vt_upload_kernel_file(p, filename, 0);
    vt_start(p, &meta, 0);

    cout << "finish running" << endl;

    // 读取结果
    vt_copy_from_dev(p, vaddr_1, data_0, 16 * 4, 0, 0); 

    cout << "\n=== dY Output (4x4 Matrix) ===" << endl;
    cout << fixed << setprecision(2);
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            cout << setw(6) << data_0[i * 4 + j] << " ";
        }
        cout << endl;
    }

    vt_copy_from_dev(p, vaddr_2, data_0, 16 * 4, 0, 0); 

    cout << "\n=== A Output (4x4 Matrix) ===" << endl;
    cout << fixed << setprecision(2);
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            cout << setw(6) << data_0[i * 4 + j] << " ";
        }
        cout << endl;
    }

    vt_copy_from_dev(p, vaddr_3, data_0, 16 * 4, 0, 0); 

    cout << "\n=== dW Output (4x4 Matrix) ===" << endl;
    cout << fixed << setprecision(2);
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            cout << setw(6) << data_0[i * 4 + j] << " ";
        }
        cout << endl;
    }


    vt_buf_free(p, 0, nullptr, 0, 0);

    return 0;
}
