import pandas as pd
import re
import os
import numpy as np
from pathlib import Path

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
            else:
                match = None
            
            if match:
                method = match.group(1)
                thread = int(match.group(2)[1:])  # 去掉"T"并转换为整数
                parameter = tuple(map(int, match.group(3).strip().replace(",", "").split("_"))) if method == "triton" else ""

                # 添加到结果列表
                results.append({
                    "benchmark": benchmark,
                    "shape": shape,
                    "method": method,
                    "thread": thread,
                    "parameter": parameter,
                    "time(s)": float(value) if value else None
                })
    
    # 转换为DataFrame
    df = pd.DataFrame(results)
    return df


def find_best_triton_params(df):
    """
    查找每个输入尺寸 shape 下，不同线程 (thread=1, 8, 32)，method 为 triton 的最短时间及对应参数。

    参数:
    df: pandas.DataFrame，包含以下列：
        - shape: 输入尺寸
        - method: 方法名称
        - thread: 线程数
        - parameter: 参数值
        - time(s): 执行时间

    返回:
    pandas.DataFrame，包含 shape、thread、最短时间及对应的参数。
    """
    # 筛选出 method 为 triton 的数据
    triton_df = df[df['method'] == 'triton']
    # 按 shape 和 thread 分组，并找到 time 最小的行
    best_params = (
        triton_df.loc[triton_df.groupby(['shape', 'thread'])['time(s)'].idxmin()]
        .reset_index(drop=True)
    )
    
    best_params['method'] = 'triton_tuned'
    return best_params


# 使用示例
if __name__ == "__main__":
    # benchmarks = ["matmul", "softmax", "correlation", "layernorm", "dropout", "rope", "resize"]
    benchmarks = ["softmax"]

    overall_df = pd.DataFrame()
    for benchmark in benchmarks:
        # input_file = f"./build-rv/build-{benchmark}/report.xls"
        input_file = f"./build-{benchmark}/report.xls"

        if not os.path.exists(input_file):
            print(f"Warning: {input_file} not found. Skipping {benchmark}...")
            continue

        origin_df = parse_performance_data(input_file, benchmark)
        origin_df.to_csv(f"./build-{benchmark}/performance_report.csv", index=False)

        triton_df = find_best_triton_params(origin_df)

        result_df = pd.concat([origin_df[origin_df['method'] == 'gcc'], origin_df[origin_df['method'] == 'clang'], triton_df], ignore_index=True)
        result_df = result_df.sort_values(by=['shape', 'method', 'thread'])
        result_df = result_df.reset_index(drop=True)
        result_df = pd.concat([origin_df[origin_df['method'] == 'triton'], result_df], ignore_index=True)

        # 新增一列Speedup，为跟对应shape下的clang_T1相比较的加速比
        result_df['speedup'] = result_df.apply(
            lambda row: round(result_df[
            (result_df['shape'] == row['shape']) & 
            (result_df['method'] == 'clang') & 
            (result_df['thread'] == 1)
            ]['time(s)'].values[0] / row['time(s)'], 4), axis=1
        )

        overall_df = pd.concat([overall_df, result_df], ignore_index=True)
    overall_df.to_csv("./performance_report_overall.csv", index=False)
