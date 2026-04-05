import base64
import json
import logging
from typing import Any

from fraud_auditor.audit import evaluate_transaction
from fraud_auditor.callback import post_audit_result
from fraud_auditor.models import TransactionEvent
from fraud_auditor.settings import get_settings

log = logging.getLogger(__name__)
if not log.handlers:
    logging.basicConfig(level=logging.INFO)


def _decode_record_body(record: dict[str, Any]) -> str:
    body = record.get("body", "")
    if record.get("isBase64Encoded"):
        body = base64.b64decode(body).decode("utf-8")
    return body


def process_sqs_event(event: dict[str, Any]) -> dict[str, Any]:
    settings = get_settings()
    failures: list[dict[str, str]] = []
    for record in event.get("Records", []):
        message_id = record.get("messageId", "")
        try:
            raw = _decode_record_body(record)
            payload = json.loads(raw)
            tx = TransactionEvent.model_validate(payload)
            decision = evaluate_transaction(tx)
            post_audit_result(settings, tx.transaction_id, decision)
        except Exception:
            log.exception("Failed processing message %s", message_id)
            if message_id:
                failures.append({"itemIdentifier": message_id})
    return {"batchItemFailures": failures}


def lambda_handler(event: dict[str, Any], context: object) -> dict[str, Any]:
    if not event:
        return {"statusCode": 400, "body": json.dumps({"error": "empty event"})}
    if "Records" in event:
        return process_sqs_event(event)
    return {"statusCode": 400, "body": json.dumps({"error": "expected SQS event"})}
