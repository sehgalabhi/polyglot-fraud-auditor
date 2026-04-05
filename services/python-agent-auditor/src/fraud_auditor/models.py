from decimal import Decimal
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field


class TransactionEvent(BaseModel):
    model_config = ConfigDict(populate_by_name=True)

    transaction_id: str = Field(alias="transactionId")
    user_id: str = Field(alias="userId")
    amount: Decimal
    currency: str
    memo: str = ""
    status: str


class AuditDecision(BaseModel):
    decision: Literal["APPROVED", "DENIED", "REVIEW"]
    reasoning: str = ""
