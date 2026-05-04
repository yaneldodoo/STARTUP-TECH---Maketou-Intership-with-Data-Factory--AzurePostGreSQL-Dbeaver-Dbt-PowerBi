import pandas as pd
from sqlalchemy import create_engine
import os

folder = "/Users/mac/maketou/data/"

engine = create_engine(
    "postgresql+psycopg2://maketouintership:Yanel2005@maketouintership.postgres.database.azure.com:5432/postgres"
)

# nettoyage des caractères NULL
def clean_df(df):
    return df.apply(lambda col: col.map(
        lambda x: x.replace('\x00', '') if isinstance(x, str) else x
    ))

for file in os.listdir(folder):

    if not file.endswith(".csv"):
        continue

    path = os.path.join(folder, file)

    print(f"\nIngestion RAW : {file}")

    df = pd.read_csv(
        path,
        sep=",",
        quotechar='"',
        encoding="latin-1",
        engine="python",
        on_bad_lines="skip"
    )

    # nettoyage obligatoire
    df = clean_df(df)

    print("Shape:", df.shape)

    if df.empty:
        print("⚠️ EMPTY FILE → skipped")
        continue

    table_name = "raw_" + file.replace(".csv", "").lower()

    df.to_sql(
        table_name,
        engine,
        if_exists="replace",
        index=False
    )

    print(f"✔ loaded : {table_name}")