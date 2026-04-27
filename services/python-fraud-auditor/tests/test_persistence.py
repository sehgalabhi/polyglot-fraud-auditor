from decimal import Decimal
from unittest.mock import MagicMock, patch

import pytest

from fraud_auditor.models import AuditDecision, TransactionEvent
from fraud_auditor.persistence import save_audit_result
from fraud_auditor.settings import Settings


def test_save_audit_result_requires_table_name() -> None:
    settings = Settings(
        aws_region="us-east-1",
        aws_endpoint="",
        sqs_transaction_events_url="https://example.com/queue",
        dynamodb_audit_table="",
    )
    event = TransactionEvent(
        transaction_id="tx-1",
        user_id="user-1",
        amount=Decimal("100.00"),
        currency="USD",
        memo="memo",
        status="PENDING_AUDIT",
    )
    decision = AuditDecision(decision="APPROVED", reasoning="ok")

    with pytest.raises(ValueError, match="DYNAMODB_AUDIT_TABLE"):
        save_audit_result(event, decision, settings)


@patch("fraud_auditor.persistence.boto3.resource")
def test_save_audit_result_puts_item(mock_resource: MagicMock) -> None:
    table = MagicMock()
    mock_resource.return_value.Table.return_value = table

    settings = Settings(
        aws_region="us-east-1",
        aws_endpoint="http://localhost:4566",
        sqs_transaction_events_url="https://example.com/queue",
        dynamodb_audit_table="dev-fraud-audit-context",
    )
    event = TransactionEvent(
        transaction_id="tx-1",
        user_id="user-1",
        amount=Decimal("100.00"),
        currency="USD",
        memo="memo",
        status="PENDING_AUDIT",
    )
    decision = AuditDecision(decision="REVIEW", reasoning="threshold exceeded")

    save_audit_result(event, decision, settings)

    mock_resource.assert_called_once_with(
        "dynamodb",
        region_name="us-east-1",
        endpoint_url="http://localhost:4566",
    )
    table.put_item.assert_called_once()
    put_item_kwargs = table.put_item.call_args.kwargs
    item = put_item_kwargs["Item"]
    assert item["transactionId"] == "tx-1"
    assert item["decision"] == "REVIEW"
    assert "auditedAt" in item
