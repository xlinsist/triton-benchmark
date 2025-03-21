import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def plot_threads_bar_chart(input_csv):
    df = pd.read_csv(input_csv)

    df = df[~df['Method'].str.contains("single")]
    df = df[df['TuningTime(s)'] != 0.0]

    shapes_to_keep = {
        "matmul": ["(512, 512, 512)"],
    }
    df = df[df.apply(lambda row: row["Shape"] in shapes_to_keep.get(row["Benchmark"], []), axis=1)]

    sns.set_theme(style="whitegrid")

    plt.figure(figsize=(6, 8))
    ax = sns.barplot(data=df, x="Benchmark", y="Speedup", hue="Method", palette="Set2")

    ax.set_xlabel(f"Benchmark", fontsize=14)
    ax.set_ylabel("Speedup", fontsize=14)
    plt.xticks(rotation=45, ha="right")

    plt.legend(title='Tuning Methods', title_fontsize='14', fontsize='14')

    output_file = f"./bar_chart_after_tuning.png"
    plt.savefig(output_file, dpi=300, bbox_inches="tight")
    print(f"Bar chart saved as {output_file}")

    plt.close()


if __name__ == "__main__":
    # TODO: Add more benchmarks. Put all benchmarks into one csv.
    for benchmark in ["matmul"]:
        plot_threads_bar_chart(f'./{benchmark}/performance_report.csv')
