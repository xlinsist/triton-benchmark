import pandas as pd
import math
import re
import os
import numpy as np
from pathlib import Path


def filter_data(df):
    """
    筛选出 thread=1, method=triton, 且在各自 benchmark 中 shape 最大的数据行。
    """
    # 1. 基础筛选：method 为 triton 且 thread 为 1
    # 注意：这里使用 copy() 避免 SettingWithCopyWarning
    filtered_df = df[
        (df['method'] == 'triton') & 
        (df['thread'] == 1)
    ].copy()
    
    if filtered_df.empty:
        return filtered_df

    # 2. 定义辅助函数：计算 shape 的“大小”
    # 通常 shape (1024, 1024) 比 (2000, 1) 大，所以建议用乘积来判断
    # 如果你想用纯粹的元组比较 (即 (2000,1) > (1024, 1024))，可以去掉这一步直接用 .max()
    def get_shape_size(shape_tuple):
        return np.prod(shape_tuple)

    # 3. 按 benchmark 分组，找出每个 benchmark 中 shape 最大的行
    def get_max_shape_rows(group):
        # 计算当前组所有行的 shape 大小
        sizes = group['shape'].apply(get_shape_size)
        # 找到最大值
        max_size = sizes.max()
        # 返回等于最大值的行（可能有多行，比如 vec_param 不同但 shape 相同）
        return group[sizes == max_size]

    # 应用分组筛选
    final_df = filtered_df.groupby('benchmark', group_keys=False).apply(get_max_shape_rows)
    
    # 重置索引
    final_df = final_df.reset_index(drop=True)
    
    return final_df


def parse_performance_data(file_path, benchmark):
    # 读取文件
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    # 提取标题和数据
    header_line = lines[1].strip()
    data_lines = lines[2:]
    
    # 获取列标题
    columns = header_line.split('\t')
    
    # 初始化存储结果的列表
    results = []
    # 解析每一行数据
    for line in data_lines:
        if not line.strip():  # 跳过空行
            continue
        entries = line.strip().split('\t')
        shape = tuple(map(int, entries[0].strip().replace(",", "").split("x")))
        values = entries[1:]
        
        for i, value in enumerate(values):
            method_info = columns[i + 1].strip()
            # 根据不同的 benchmark 类型来选择合适的正则表达式
            if benchmark == "matmul":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_matmul_kernel_(\d+_\d+_\d+))?', method_info)
            elif benchmark == "resize":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_resize_kernel_(\d+))?', method_info)
            elif benchmark == "add":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_add_kernel_(\d+_\d+))?', method_info)
            elif benchmark == "softmax":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_softmax_kernel_(\d+_\d+))?', method_info)
            elif benchmark == "dropout":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_dropout_kernel_(\d+_\d+))?', method_info)
            elif benchmark == "correlation":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_correlation_kernel_(\d+_\d+))?', method_info)
            elif benchmark == "layernorm":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:__layer_norm_fwd_fused_(\d+))?', method_info)
            elif benchmark == "rope":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_rope_kernel_(\d+))?', method_info)
            elif benchmark == "warp":
                match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_warp_kernel_(\d+))?', method_info)
            else:
                match = None
            
            if match:
                method = match.group(1)
                thread = int(match.group(2)[1:])  # 去掉"T"并转换为整数
                
                vec_param = None # 默认为 None (针对 gcc/clang 或者解析失败的情况)
                block_param = None
                
                # 只有 method 为 triton 且正则捕获组3存在时才处理参数
                if method == "triton" and match.group(3):
                    # 先解析出完整的参数列表
                    full_params = list(map(int, match.group(3).strip().replace(",", "").split("_")))
                    # 取最后一个参数作为 vec_param
                    vec_param = full_params[-1]
                    block_param = tuple(full_params[:-1])
                # 添加到结果列表
                results.append({
                    "benchmark": benchmark,
                    "shape": shape,
                    "method": method,
                    "thread": thread,
                    "block_param": block_param,
                    "vec_param": vec_param,
                    "time(ms)": round(float(value) * 1000, 4) if value else None
                })
    
    # 转换为DataFrame
    df = pd.DataFrame(results)
    return df


def find_best_triton_params(df):
    # 筛选出 method 为 triton 的数据
    triton_df = df[df['method'] == 'triton']
    if triton_df.empty:
        return triton_df.copy()

    # 按 shape 和 thread 分组，并找到 time 最小的所有行（处理平局情况）
    min_times = triton_df.groupby(['shape', 'thread'])['time(ms)'].transform('min')
    best_params = triton_df[triton_df['time(ms)'] == min_times].reset_index(drop=True)

    best_params['method'] = 'triton_tuned'
    return best_params


# 使用示例
if __name__ == "__main__":
    benchmarks = ["add"]
    # benchmarks = ["matmul", "softmax", "layernorm", "rope", "resize", "dropout", "correlation", "warp"]

    overall_df = pd.DataFrame()
    for benchmark in benchmarks:
        input_file = f"../build-{benchmark}/report.xls"

        if not os.path.exists(input_file):
            print(f"Warning: {input_file} not found. Skipping {benchmark}...")
            continue

        origin_df = parse_performance_data(input_file, benchmark)
        origin_df.to_csv(f"../build-{benchmark}/performance_report.csv", index=False)

        if origin_df.empty:
            print(f"Warning: No data parsed from {input_file}. Skipping processing for {benchmark}.")
            continue
        triton_df = find_best_triton_params(origin_df)
        result_df = pd.concat([origin_df[origin_df['method'] == 'triton'], triton_df], ignore_index=True)
        result_df = result_df.sort_values(by=['shape', 'method', 'thread', 'block_param', 'vec_param'])
        result_df = result_df.reset_index(drop=True)

        # 新增一列Speedup，为跟对应shape下的clang_T1相比较的加速比
        # result_df['speedup'] = result_df.apply(
        #     lambda row: round(result_df[
        #     (result_df['shape'] == row['shape']) & 
        #     (result_df['method'] == 'clang') & 
        #     (result_df['thread'] == 1)
        #     ]['time(ms)'].values[0] / row['time(ms)'], 4), axis=1
        # )

        overall_df = pd.concat([overall_df, result_df], ignore_index=True)
    overall_df.to_csv("../performance_report_overall.csv", index=False)
    # filter_df = filter_data(overall_df)
    # filter_df.to_csv("../performance_report_filtered.csv", index=False)
