import logging

import httpx

from fraud_auditor.models import AuditDecision
from fraud_auditor.settings import Settings

log = logging.getLogger(__name__)


def post_audit_result(
    settings: Settings,
    transaction_id: str,
    decision: AuditDecision,
) -> None:
    if not settings.audit_callback_url:
        log.warning("AUDIT_CALLBACK_URL not set; skipping callback for %s", transaction_id)
        return
    payload = {
        "transactionId": transaction_id,
        "decision": decision.decision,
        "reasoning": decision.reasoning,
    }
    headers = {}
    if settings.audit_callback_secret:
        headers["X-Agent-Secret"] = settings.audit_callback_secret
    with httpx.Client(timeout=30.0) as client:
        r = client.post(settings.audit_callback_url, json=payload, headers=headers)
        r.raise_for_status()
