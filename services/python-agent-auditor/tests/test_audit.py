from decimal import Decimal

from fraud_auditor.audit import evaluate_transaction
from fraud_auditor.models import TransactionEvent


def test_evaluate_small_amount_approved() -> None:
    tx = TransactionEvent.model_validate(
        {
            "transactionId": "t1",
            "userId": "u1",
            "amount": "100.00",
            "currency": "USD",
            "memo": "",
            "status": "PENDING_AUDIT",
        }
    )
    d = evaluate_transaction(tx)
    assert d.decision == "APPROVED"


def test_evaluate_large_amount_review() -> None:
    tx = TransactionEvent(
        transaction_id="t2",
        user_id="u1",
        amount=Decimal("10001.00"),
        currency="USD",
        memo="",
        status="PENDING_AUDIT",
    )
    d = evaluate_transaction(tx)
    assert d.decision == "REVIEW"
