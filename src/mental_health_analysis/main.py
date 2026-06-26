import pandas as pd

from mental_health_analysis import constants as const


def main() -> None:

    df = pd.read_csv(const.RAW_DATA_DIR_PATH / "mental-health-in-tech-2016.csv")
    print(df)


if __name__ == "__main__":
    main()
