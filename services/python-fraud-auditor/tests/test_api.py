from unittest.mock import patch

from fastapi.testclient import TestClient

from fraud_auditor.api import app

client = TestClient(app)


def test_health_ok() -> None:
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


@patch("fraud_auditor.api.save_audit_result")
def test_audit_returns_decision_and_persisted(mock_save) -> None:
    response = client.post(
        "/v1/audit",
        json={
            "transaction_id": "tx-1",
            "user_id": "user-1",
            "amount": "100.00",
            "currency": "USD",
            "memo": "test",
            "status": "PENDING_AUDIT",
        },
    )

    assert response.status_code == 200
    body = response.json()
    assert body["decision"] in {"APPROVED", "REVIEW"}
    assert "reasoning" in body
    assert body["persisted"] is True
    mock_save.assert_called_once()
