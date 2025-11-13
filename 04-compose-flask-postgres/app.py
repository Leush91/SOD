from flask import Flask
import os, psycopg2

app = Flask(__name__)

def get_db_version():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST","db"),
        port=os.getenv("DB_PORT","5432"),
        user=os.getenv("DB_USER","app"),
        password=os.getenv("DB_PASSWORD","secret"),
        dbname=os.getenv("DB_NAME","appdb"),
    )
    cur = conn.cursor()
    cur.execute("SELECT version();")
    v = cur.fetchone()[0]
    cur.close(); conn.close()
    return v

@app.route("/")
def index():
    return f"Connected to Postgres: {get_db_version()}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

