"""The main module for the data cleaning processes, so that the data is ready for analysis.
It grabs data from the data/raw/ directory, and then outputting it in data/processed/"""

import pandas as pd
from mental_health_analysis import constants as const


def main() -> None:
    df: pd.DataFrame = pd.read_csv(
        const.RAW_DATA_DIR_PATH / "mental_health_burnout_tech_2026.csv"
    )

    # initial_memory_usage = df.memory_usage(deep=True).sum()

    unnecessary_columns: list[str] = [
        "employee_id",
        "age",
        "gender",
        "job_role",
        "years_experience",
        "years_at_company",
        "industry",
        "exercise_days_per_week",
        "vacation_days_taken",
        "ai_tools_daily",
        "job_change_intention",
        "therapy_access",
    ]

    df = df.drop(columns=unnecessary_columns)

    # after_drop_column_memory_usage = df.memory_usage(deep=True).sum()

    float_columns = df.select_dtypes(include="float64").columns
    df[float_columns] = df[float_columns].apply(
        lambda column: pd.to_numeric(column, downcast="float")
    )

    int_columns = df.select_dtypes(include="int64").columns
    df[int_columns] = df[int_columns].apply(
        lambda column: pd.to_numeric(column, downcast="integer")
    )

    binary_columns = [
        column for column in df.columns if set(df[column].unique()).issubset([0, 1])
    ]
    df[binary_columns] = df[binary_columns].astype("bool")

    # after_downcast_memory_usage = df.memory_usage(deep=True).sum()

    # Uncomment these and the variables above if you want to see the memory saved statistics.
    # print(f"Initial: {initial_memory_usage}")
    # print(f"After droppping columns: {after_drop_column_memory_usage} ")
    # print(f"Saved {(initial_memory_usage - after_drop_column_memory_usage) / initial_memory_usage * 100}% memory")
    # print(f"After downcasting memory usage: {after_downcast_memory_usage}")
    # print(f"Saved {(after_drop_column_memory_usage - after_downcast_memory_usage) / after_drop_column_memory_usage * 100}% memory")

    # Uncomment these two lines if you want to see the unique values of each column
    for column in df:
        print(f"{column} ({df[column].dtype}):", df[column].unique())

    # print(df.duplicated().sum() == 0) This is True, meaning there are no duplicate values in this dataset.
    # print(df.isnull().sum() == 0) This returns an all True dataset, meaning there are also no null values.

    df.to_csv(
        const.PROCESSED_DATA_DIR_PATH / "processed.csv", index=False, encoding="utf-8"
    )
    print(
        "Cleaning finished, look at data/processed/processed.csv to see your new processed csv"
    )


if __name__ == "__main__":
    main()
