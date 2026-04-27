import base64
import json
import logging
from typing import Any

from fraud_auditor.audit import evaluate_transaction
from fraud_auditor.models import TransactionEvent
from fraud_auditor.persistence import save_audit_result
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
    # Lambda partial batch response contract:
    # only messages listed in batchItemFailures are retried by SQS event source mapping.
    failures: list[dict[str, str]] = []
    for record in event.get("Records", []):
        message_id = record.get("messageId", "")
        try:
            # 1) Decode SQS body
            raw = _decode_record_body(record)
            # 2) Parse JSON
            payload = json.loads(raw)
            # 3) Validate contract and run audit logic
            tx = TransactionEvent.model_validate(payload)
            decision = evaluate_transaction(tx)
            # 4) Persist audit outcome; if this fails the message is marked for retry.
            save_audit_result(tx, decision, settings)
            log.info("Processed message %s with decision=%s", message_id, decision.decision)
        except Exception:
            log.exception("Failed processing message %s", message_id)
            if message_id:
                failures.append({"itemIdentifier": message_id})
    return {"batchItemFailures": failures}
