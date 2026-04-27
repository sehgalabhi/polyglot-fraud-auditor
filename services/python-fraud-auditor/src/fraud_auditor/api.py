from decimal import Decimal

from fastapi import FastAPI
from pydantic import BaseModel, Field

from fraud_auditor.audit import evaluate_transaction
from fraud_auditor.models import AuditDecision, TransactionEvent

app = FastAPI(title="Fraud agent auditor", version="0.1.0")


class AuditRequest(BaseModel):
    transaction_id: str = Field(examples=["550e8400-e29b-41d4-a716-446655440000"])
    user_id: str = "local-user"
    amount: Decimal = Field(examples=[Decimal("5000.00")])
    currency: str = "USD"
    memo: str = ""
    status: str = "PENDING_AUDIT"


class AuditResponse(BaseModel):
    decision: str
    reasoning: str


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/v1/audit", response_model=AuditResponse)
def audit(body: AuditRequest) -> AuditResponse:
    event = TransactionEvent.model_validate(
        {
            "transactionId": body.transaction_id,
            "userId": body.user_id,
            "amount": body.amount,
            "currency": body.currency,
            "memo": body.memo,
            "status": body.status,
        }
    )
    decision: AuditDecision = evaluate_transaction(event)
    return AuditResponse(
        decision=decision.decision,
        reasoning=decision.reasoning,
    )
