"""
Long-poll LocalStack / AWS SQS and run the same path as Lambda (audit + webhook callback).
Use with LocalStack Tier 1: same env vars as the Java engine for queue + endpoint.
"""

from __future__ import annotations

import logging
import signal
import sys
import time
from typing import Any

import boto3

from fraud_auditor.handler import process_sqs_event
from fraud_auditor.settings import get_settings

log = logging.getLogger(__name__)

_running = True


def _stop(*_: Any) -> None:
    global _running
    _running = False


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")
    signal.signal(signal.SIGINT, _stop)
    signal.signal(signal.SIGTERM, _stop)

    settings = get_settings()
    if not settings.sqs_transaction_events_url:
        log.error("Set SQS_TRANSACTION_EVENTS_URL (same value as the Java service).")
        sys.exit(1)

    client_kw: dict[str, Any] = {"region_name": settings.aws_region}
    if settings.aws_endpoint:
        client_kw["endpoint_url"] = settings.aws_endpoint

    client = boto3.client("sqs", **client_kw)
    url = settings.sqs_transaction_events_url
    log.info("Polling %s (Ctrl+C to stop)", url)

    while _running:
        resp = client.receive_message(
            QueueUrl=url,
            MaxNumberOfMessages=10,
            WaitTimeSeconds=20,
            VisibilityTimeout=60,
        )
        messages = resp.get("Messages") or []
        if not messages:
            continue

        for msg in messages:
            mid = msg.get("MessageId") or ""
            body = msg.get("Body") or ""
            receipt = msg.get("ReceiptHandle")
            event: dict[str, Any] = {
                "Records": [
                    {
                        "messageId": mid,
                        "body": body,
                    }
                ]
            }
            try:
                result = process_sqs_event(event)
                failed = {f["itemIdentifier"] for f in result.get("batchItemFailures", [])}
                if mid not in failed and receipt:
                    client.delete_message(QueueUrl=url, ReceiptHandle=receipt)
                    log.info("Processed and deleted message %s", mid)
                elif mid in failed:
                    log.warning("Message %s left on queue for retry", mid)
            except Exception:
                log.exception("Unexpected error for message %s", mid)

        time.sleep(0.05)


if __name__ == "__main__":
    main()
