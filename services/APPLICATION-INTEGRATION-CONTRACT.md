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

## Local run order (minimal flow)

1. Start LocalStack or use provisioned AWS resources.
2. Export required env vars for both apps:
   - `AWS_REGION`
   - `AWS_ENDPOINT` (if LocalStack)
   - `SQS_TRANSACTION_EVENTS_URL`
   - `DYNAMODB_AUDIT_TABLE` (for Python)
3. Start Python poller:
   - `cd services/python-fraud-auditor`
   - `uv run dev-sqs-poll`
4. Start Java API:
   - `cd services/java-transaction-producer`
   - `mvn spring-boot:run`
5. POST a transaction to Java:
   - `POST /api/v1/transactions`
6. Verify:
   - Python logs show message processed and decision computed.
   - DynamoDB contains an audit record for the `transactionId`.

## Local API response shape

`POST /v1/audit` (Python FastAPI) returns:

```json
{
  "decision": "APPROVED",
  "reasoning": "Amount is within automated threshold (10000).",
  "persisted": true
}
```
