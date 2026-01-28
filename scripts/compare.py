import pandas as pd
import sys

def compare_performance(file1, file5, output_file):
    """
    Compares the 'time(ms)' column of two performance report CSV files and
    calculates the speedup ratio.

    Args:
        file1 (str): Path to the first CSV file (e.g., performance_report_overall_1.csv).
        file5 (str): Path to the second CSV file (e.g., performance_report_overall_5.csv).
        output_file (str): Path to save the resulting comparison CSV.
    """
    try:
        # Read the two CSV files into pandas DataFrames
        df1 = pd.read_csv(file1)
        df5 = pd.read_csv(file5)

        # Ensure the DataFrames have the same structure to compare row by row
        if df1.shape != df5.shape or not all(df1.columns == df5.columns):
            print("Error: The structure (shape or columns) of the two files is different.")
            # For more robustness, one could merge based on key columns,
            # but for this script, we assume matching rows.
            return

        # Create a copy of the first DataFrame to store the results
        df_compare = df1.copy()

        # Calculate the speedup ratio (time_in_file5 / time_in_file1)
        # A ratio > 1 means file1 is faster than file5.
        speedup_ratio = df5['time(ms)'] / df1['time(ms)']

        # Replace the 'time(ms)' column with the calculated speedup ratio
        df_compare['time(ms)'] = speedup_ratio
        
        # It's good practice to rename the column to reflect its new content
        df_compare.rename(columns={'time(ms)': 'speedup_ratio(5_vs_1)'}, inplace=True)


        # Save the resulting DataFrame to the output CSV file
        df_compare.to_csv(output_file, index=False, float_format='%.4f')

        print(f"Comparison successful. Output saved to '{output_file}'")

    except FileNotFoundError as e:
        print(f"Error: File not found - {e}")
        sys.exit(1)
    except KeyError:
        print("Error: 'time(ms)' column not found in one of the files.")
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python compare.py <path_to_report_1.csv> <path_to_report_2.csv>")
        print("Example: python scripts/compare.py performance_report_overall_1.csv performance_report_overall_2.csv")
        sys.exit(1)
    
    file_1 = sys.argv[1]
    file_2 = sys.argv[2]
    output_csv = 'compare.csv'
    
    compare_performance(file_1, file_5, output_csv)
