#!/bin/bash
set -eu
# Runs inside the LocalStack container once the gateway is ready.
awslocal sqs create-queue --queue-name transaction-events >/dev/null 2>&1 || true
echo "[localstack-init] transaction-events queue URL:"
awslocal sqs get-queue-url --queue-name transaction-events --output text
