# Application Integration Contract

This document defines the shared runtime configuration and SQS message contract between:
- `services/java-transaction-producer`
- `services/python-fraud-auditor`

## Required environment variables

- `AWS_REGION` (example: `us-east-1`)
- `AWS_ENDPOINT` (optional; LocalStack example: `http://localhost:4566`)
- `SQS_TRANSACTION_EVENTS_URL` (full queue URL)
- `DYNAMODB_AUDIT_TABLE` (used by Python consumer for audit persistence)

## Canonical transaction event payload

Java publishes this JSON shape; Python parses the same fields.

```json
{
  "transactionId": "550e8400-e29b-41d4-a716-446655440000",
  "userId": "user-1",
  "amount": 5000.00,
  "currency": "USD",
  "memo": "Wire transfer",
  "status": "PENDING_AUDIT"
}
```
