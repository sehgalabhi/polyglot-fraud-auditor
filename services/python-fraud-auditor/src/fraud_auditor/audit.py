import logging
from decimal import Decimal

from fraud_auditor.models import AuditDecision, TransactionEvent

log = logging.getLogger(__name__)
REVIEW_THRESHOLD = Decimal("10000")


def evaluate_transaction(event: TransactionEvent) -> AuditDecision:
    """
    Baseline deterministic risk rules.
    This module is intentionally simple and uses deterministic baseline rules.
    """
    # Single baseline rule: large-value transactions are routed for manual review.
    if event.amount > REVIEW_THRESHOLD:
        return AuditDecision(
            decision="REVIEW",
            reasoning=f"Amount exceeds review threshold ({REVIEW_THRESHOLD}).",
        )
    return AuditDecision(
        decision="APPROVED",
        reasoning=f"Amount is within automated threshold ({REVIEW_THRESHOLD}).",
    )
