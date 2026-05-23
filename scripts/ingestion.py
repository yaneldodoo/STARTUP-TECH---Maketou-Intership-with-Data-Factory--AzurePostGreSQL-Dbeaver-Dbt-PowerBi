import os
import pandas as pd
import psycopg2
from io import StringIO

folder = "/Users/mac/maketou/data/"

conn = psycopg2.connect(
    host="localhost",
    database="postgres",
    user="mac",
    password="postgres",
    port=5432
)

cursor = conn.cursor()


def read_csv_safe(path):
    encodings = ["utf-8", "latin1", "ISO-8859-1", "cp1252"]

    for enc in encodings:
        try:
            print(f"encodage: {enc}")

            df = pd.read_csv(
                path,
                encoding=enc,
                engine="python",
                on_bad_lines="skip"
            )

            print(f"ok {enc} | lignes: {len(df)}")
            return df

        except Exception:
            print(f"fail {enc}")

    raise Exception("impossible lecture")


def clean_dataframe(df):
    # supprimer NULL bytes
    df = df.replace({r"\x00": ""}, regex=True)

    # enlever colonnes dupliquées BRUTES
    df = df.loc[:, ~df.columns.duplicated()]

    return df


# 🔥 FIX ULTRA IMPORTANT : éviter duplicates après nettoyage
def fix_column_names(cols):
    seen = {}
    new_cols = []

    for c in cols:
        c = str(c).strip().lower().replace(" ", "_").replace("-", "_")

        # si colonne existe déjà → rename automatique
        if c in seen:
            seen[c] += 1
            c = f"{c}_{seen[c]}"
        else:
            seen[c] = 0

        new_cols.append(c)

    return new_cols


def copy_to_postgres(df, table_name):

    # clean colonnes
    df.columns = fix_column_names(df.columns)

    # tout en string safe
    df = df.astype(str)

    # création table safe
    cols = ", ".join([f"{c} TEXT" for c in df.columns])

    cursor.execute(f"DROP TABLE IF EXISTS {table_name}")
    cursor.execute(f"CREATE TABLE {table_name} ({cols})")
    conn.commit()

    # COPY rapide
    buffer = StringIO()
    df.to_csv(buffer, index=False, header=False)
    buffer.seek(0)

    cursor.copy_expert(
        f"COPY {table_name} FROM STDIN WITH CSV",
        buffer
    )

    conn.commit()


for file in os.listdir(folder):
    if not file.endswith(".csv"):
        continue

    path = os.path.join(folder, file)

    print(f"\nfichier: {file}")

    df = read_csv_safe(path)
    df = clean_dataframe(df)

    table = "raw_" + file.replace(".csv", "").lower()

    print(f"table: {table} | lignes: {len(df)}")

    copy_to_postgres(df, table)

print("ingestion terminée")