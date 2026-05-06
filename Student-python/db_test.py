import os
from sqlalchemy import create_engine

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "3306")
DB_NAME = os.getenv("DB_NAME")

DATABASE_URL = (
    f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}?ssl=true"
)

engine = create_engine(DATABASE_URL)

try:
    conn = engine.connect()
    print("✅ DB CONNECTED SUCCESSFULLY")
    conn.close()

except Exception as e:
    print("❌ DB CONNECTION FAILED")
    print("Error Type:", type(e).__name__)
    print("Error Details:", str(e))
