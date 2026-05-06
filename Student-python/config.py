import os

class Config:
    # Read environment variables correctly
    DB_HOST = os.environ.get("DB_HOST")
    DB_PORT = os.environ.get("DB_PORT", "3306")
    DB_NAME = os.environ.get("DB_NAME")
    DB_USER = os.environ.get("DB_USER")
    DB_PASSWORD = os.environ.get("DB_PASSWORD")

    # SQLAlchemy connection string
    SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://{DB_NAME}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_USER}"
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    SQLALCHEMY_ENGINE_OPTIONS = {
    "connect_args": {
        "ssl": {
            "ca": "/etc/ssl/certs/ca-certificates.crt"
        }
    }
}
