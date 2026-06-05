import psycopg2

conn = psycopg2.connect(
    dbname="analytics",
    user="maketou",
    password="maketou",
    host="localhost",
    port="5433"
)

print("OK DB CONNECTED")