from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Runtime config for the Python SQS -> audit -> DynamoDB flow."""
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # Shared env contract with Java service.
    aws_region: str = "us-east-1"
    # Optional endpoint override for LocalStack/dev.
    aws_endpoint: str = ""
    # Must match Java producer queue URL.
    sqs_transaction_events_url: str = ""
    # DynamoDB table for persisted audit decisions.
    dynamodb_audit_table: str = ""


def get_settings() -> Settings:
    return Settings()
