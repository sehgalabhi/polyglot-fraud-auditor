from unittest.mock import patch

from fraud_auditor.handler import process_sqs_event
from fraud_auditor.models import AuditDecision


def _event_with_one_record(body: str, message_id: str = "m1") -> dict:
    return {
        "Records": [
            {
                "messageId": message_id,
                "body": body,
            }
        ]
    }


@patch("fraud_auditor.handler.save_audit_result")
@patch("fraud_auditor.handler.evaluate_transaction")
def test_process_sqs_event_success_returns_no_failures(
    mock_evaluate,
    mock_save,
) -> None:
    mock_evaluate.return_value = AuditDecision(decision="APPROVED", reasoning="ok")
    event = _event_with_one_record(
        '{"transactionId":"t1","userId":"u1","amount":"100.00","currency":"USD","memo":"","status":"PENDING_AUDIT"}'
    )

    result = process_sqs_event(event)

    assert result == {"batchItemFailures": []}
    mock_evaluate.assert_called_once()
    mock_save.assert_called_once()


def test_process_sqs_event_invalid_payload_marks_failure() -> None:
    # Invalid JSON body should mark this message for retry.
    event = _event_with_one_record("{not-json}", message_id="m2")

    result = process_sqs_event(event)

    assert result == {"batchItemFailures": [{"itemIdentifier": "m2"}]}
