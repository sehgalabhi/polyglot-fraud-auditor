# AWS SQS Stack

This stack provisions the must-have SQS messaging resources for fraud alerts.

## Resources Created

- `aws_sqs_queue.alerts_dlq`: dead-letter queue for failed messages
- `aws_sqs_queue.alerts`: main alerts queue with redrive policy to DLQ

## Variables Used

- Optional (with defaults):
  - `project_name`
  - `environment`
  - `aws_region`
  - `aws_endpoint_override` (localstack/dev)
  - `alerts_queue_name`
  - `alerts_dlq_name`
  - `alerts_max_receive_count`
  - `tags`

## Outputs

- `alerts_queue_name`, `alerts_queue_url`, `alerts_queue_arn`
- `alerts_dlq_name`, `alerts_dlq_url`, `alerts_dlq_arn`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
