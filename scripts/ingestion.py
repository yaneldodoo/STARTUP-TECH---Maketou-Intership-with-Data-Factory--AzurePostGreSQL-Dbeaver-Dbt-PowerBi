import os
import pandas as pd
import psycopg2
from io import StringIO

folder = "/Users/mac/maketou/data/"

conn = psycopg2.connect(
    host="localhost",
    database="analytics",
    user="maketou",
    password="maketou",
    port=5433
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

    # enlever colonnes dupliquées
    df = df.loc[:, ~df.columns.duplicated()]

    return df


def fix_column_names(cols):

    seen = {}
    new_cols = []

    for c in cols:

        c = (
            str(c)
            .strip()
            .lower()
            .replace(" ", "_")
            .replace("-", "_")
        )

        # éviter doublons après nettoyage
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

    # remplacer NaN
    df = df.fillna("").astype(str)

    # création SQL colonnes
    cols = ", ".join([f"{c} TEXT" for c in df.columns])

    # vérifier si table existe
    cursor.execute("""
    SELECT EXISTS (
        SELECT FROM information_schema.tables
        WHERE table_name = %s
    )
    """, (table_name,))

    exists = cursor.fetchone()[0]

    # si table existe pas → CREATE
    if not exists:

        print(f"création table: {table_name}")

        cursor.execute(
            f"CREATE TABLE {table_name} ({cols})"
        )

    # si existe → vider seulement
    else:

        print(f"truncate table: {table_name}")

        cursor.execute(
            f"TRUNCATE TABLE {table_name}"
        )

    conn.commit()

    # buffer CSV mémoire
    buffer = StringIO()

    df.to_csv(
        buffer,
        index=False,
        header=False
    )

    buffer.seek(0)

    # COPY PostgreSQL ultra rapide
    cursor.copy_expert(
        f"COPY {table_name} FROM STDIN WITH CSV",
        buffer
    )

    conn.commit()

    print(f"ingéré: {table_name}")


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


cursor.close()
conn.close()

print("\ningestion terminée")