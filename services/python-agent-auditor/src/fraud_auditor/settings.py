from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    audit_callback_url: str = ""
    audit_callback_secret: str = ""
    aws_region: str = "us-east-1"


def get_settings() -> Settings:
    return Settings()
