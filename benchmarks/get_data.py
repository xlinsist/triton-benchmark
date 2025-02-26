import pandas as pd
import re
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
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
    result_df = pd.concat([df, best_params[['benchmark' ,'shape', 'thread', 'parameter', 'time(s)', 'method']]], ignore_index=True)
    return result_df


# 使用示例
if __name__ == "__main__":
    benchmarks = ["matmul", "resize", "softmax", "dropout", "correlation", "layernorm"]
    # benchmarks = ["layernorm"]
    overall_df = pd.DataFrame()
    for benchmark in benchmarks:
        input_file = f"./build-{benchmark}-tuning/report.xls"  # 替换为你的文件路径
        df = parse_performance_data(input_file, benchmark)
        result_df = find_best_triton_params(df)
        # result_df.to_csv(f"./build-{benchmark}-tuning/performance_report.csv", index=False)
        overall_df = pd.concat([overall_df, result_df[result_df['method'] == 'triton_tuned']], ignore_index=True)
    overall_df.to_csv("./performance_report_overall.csv", index=False)
