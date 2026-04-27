from __future__ import annotations

from datetime import datetime, timezone
from typing import Any

import boto3

from fraud_auditor.models import AuditDecision, TransactionEvent
from fraud_auditor.settings import Settings


def save_audit_result(event: TransactionEvent, decision: AuditDecision, settings: Settings) -> None:
    """
    Persist one audit result row into DynamoDB.
    """
    table_name = settings.dynamodb_audit_table
    if not table_name:
        raise ValueError("DYNAMODB_AUDIT_TABLE is required")

    dynamodb_kwargs: dict[str, Any] = {"region_name": settings.aws_region}
    if settings.aws_endpoint:
        dynamodb_kwargs["endpoint_url"] = settings.aws_endpoint

    table = boto3.resource("dynamodb", **dynamodb_kwargs).Table(table_name)
    table.put_item(
        Item={
            "transactionId": event.transaction_id,
            "userId": event.user_id,
            "amount": event.amount,
            "currency": event.currency,
            "memo": event.memo,
            "status": event.status,
            "decision": decision.decision,
            "reasoning": decision.reasoning,
            "auditedAt": datetime.now(timezone.utc).isoformat(),
        }
    )
