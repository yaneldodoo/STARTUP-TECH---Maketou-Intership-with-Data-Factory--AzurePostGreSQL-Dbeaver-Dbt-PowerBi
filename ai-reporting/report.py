import psycopg2
import pandas as pd

conn = psycopg2.connect(
    dbname="analytics",
    user="maketou",
    password="maketou",
    host="localhost",
    port="5433"
)

tables = [
    "dbt.gold_boutique",
    "dbt.gold_kyc",
    "dbt.gold_users",
    "dbt.gold_payment",
    "dbt.gold_tauxconversion",
    "dbt.gold_useraveckycnonvalidé",
    "dbt.gold_duree_tentativekyc",
    "dbt.gold_kyc_reasons_refus",
    "dbt.gold_kyc_kpi",



]

def get_data():
    data_blocks = ""

    for t in tables:
        df = pd.read_sql(f"SELECT * FROM {t}", conn) 

        data_blocks += f"\n\nTABLE: {t}\n"
        data_blocks += f"SHAPE: {df.shape}\n"
        data_blocks += df.describe(include="all").to_string()
        data_blocks += "\nSAMPLE:\n"
        data_blocks += df.head(10).to_string()

    return data_blocks