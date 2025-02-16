import pandas as pd
import re
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from pathlib import Path

def parse_performance_data(file_path):
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
        shape = entries[0].strip()
        values = entries[1:]
        
        for i, value in enumerate(values):
            method_info = columns[i + 1].strip()
            
            # 提取method, thread, and parameter
            # match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_matmul_kernel_(\d+_\d+_\d+))?', method_info) # for matmul
            # match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_softmax_kernel_(\d+_\d+))?', method_info) # for softmax
            # match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_dropout_kernel_(\d+_\d+))?', method_info) # for dropout
            match = re.match(r'(gcc|clang|triton)_(T\d+)(?:_resize_kernel_(\d+))?', method_info) # for dropout
            if match:
                method = match.group(1)
                thread = int(match.group(2)[1:])  # 去掉"T"并转换为整数
                parameter = match.group(3) if method == "triton" else ""
                # 添加到结果列表
                results.append({
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
    result_df = pd.concat([df, best_params[['shape', 'thread', 'parameter', 'time(s)', 'method']]], ignore_index=True)
    return result_df


def plot_threads_bar_chart(input_csv):
    # 读取 CSV 数据
    df = pd.read_csv(input_csv)

    # 筛选出 method 为 "triton_tuned" 的数据
    df = df[df["method"] == "triton_tuned"]
    # 只保留指定的 shape
    shapes_to_keep = ["64,x100", "1024,x100", "16384,x100", "262144,x100"]
    df = df[df["shape"].isin(shapes_to_keep)]
    
    # 按照指定顺序排序
    df["shape"] = pd.Categorical(df["shape"], categories=shapes_to_keep, ordered=True)
    df = df.sort_values("shape")

    # 设置 Seaborn 样式
    sns.set_theme(style="whitegrid")

    # 画图
    plt.figure(figsize=(12, 6))
    ax = sns.barplot(data=df, x="shape", y="time(s)", hue="thread", palette="Set2")

    # 设置图表信息
    ax.set_xlabel("Shape", fontsize=12)
    ax.set_ylabel("Time (s)", fontsize=12)
    ax.set_title("Execution Time for Different Shapes and Threads", fontsize=14)
    plt.xticks(rotation=45, ha="right")

    # 保存图表
    output_file = f"./build/bar_chart_triton_tuned.png"
    plt.savefig(output_file, dpi=300, bbox_inches="tight")
    print(f"Bar chart saved as {output_file}")

    plt.close()


# 使用示例
if __name__ == "__main__":
    input_file = "./build/report.xls"  # 替换为你的文件路径
    df = parse_performance_data(input_file)
    result_df = find_best_triton_params(df)
    # print(result_df)
    result_df.to_csv("./build/performance_report.csv", index=False)
    # plot_threads_bar_chart("./build/performance_report.csv")
