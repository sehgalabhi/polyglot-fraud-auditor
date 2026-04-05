import logging
from decimal import Decimal

from fraud_auditor.models import AuditDecision, TransactionEvent

log = logging.getLogger(__name__)


def evaluate_transaction(event: TransactionEvent) -> AuditDecision:
    """
    Placeholder risk logic. Replace with RAG + LLM (Bedrock / Azure OpenAI) and guardrails.
    """
    if event.amount > Decimal("10000"):
        return AuditDecision(
            decision="REVIEW",
            reasoning="Amount exceeds automatic threshold; manual review recommended.",
        )
    return AuditDecision(decision="APPROVED", reasoning="Within placeholder rules.")
