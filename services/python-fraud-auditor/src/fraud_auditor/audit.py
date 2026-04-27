import logging
from decimal import Decimal

from fraud_auditor.models import AuditDecision, TransactionEvent

log = logging.getLogger(__name__)


def evaluate_transaction(event: TransactionEvent) -> AuditDecision:
    """
    Baseline deterministic risk rules.
    This module is intentionally simple and can be extended with Bedrock-backed inference.
    """
    if event.amount > Decimal("10000"):
        return AuditDecision(
            decision="REVIEW",
            reasoning="Amount exceeds automatic threshold; manual review recommended.",
        )
    return AuditDecision(decision="APPROVED", reasoning="Within baseline risk thresholds.")
