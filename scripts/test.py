import pandas as pd

path = "/Users/mac/maketou/data/payment.csv"

df = pd.read_csv(
    path,
    sep=",",
    quotechar='"',
    encoding="latin-1",
    engine="python"
)

print(df.head())