"""The main module for the data cleaning processes, so that the data is ready for analysis.
It grabs data from the data/raw/ directory, and then outputting it in data/processed/"""

import pandas as pd
import numpy as np

from mental_health_analysis import constants as const


def main() -> None:
    df: pd.DataFrame = pd.read_csv(
        const.RAW_DATA_DIR_PATH / "mental-health-in-tech-2016.csv"
    )
    # Dropped because it is meant to be a global analysis, not one focused on the US only.
    # A global analysis wouldn't need this type of data.
    df = df.drop(
        columns=[
            "What US state or territory do you live in?",
            "What US state or territory do you work in?",
        ]
    )
    general_value_map: dict = {
        "1": True,
        "0": False,
        "yes": True,
        "no": False,
        "i don't know": np.nan,
        "maybe": np.nan,
        "n/a": np.nan,
        "i'm not sure": np.nan,
        "unsure": np.nan,
    }

    for column_name, column_values in df.items():
        df[column_name] = (
            column_values.astype(str).str.lower().replace(general_value_map)
        )

    df.to_csv(
        const.PROCESSED_DATA_DIR_PATH / "processed.csv", index=False, encoding="utf-8"
    )


if __name__ == "__main__":
    main()
