from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # Shared env contract with Java service.
    aws_region: str = "us-east-1"
    # Same names as the Java service.
    aws_endpoint: str = ""
    sqs_transaction_events_url: str = ""
    dynamodb_audit_table: str = ""


def get_settings() -> Settings:
    return Settings()
