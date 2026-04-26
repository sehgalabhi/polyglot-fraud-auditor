# AWS DynamoDB Stack

This stack provisions a single DynamoDB table for fraud audit / RAG context (must-haves only).

## Resources Created

- `aws_dynamodb_table.audit_context`: on-demand (PAY_PER_REQUEST) table with a string partition key

## Variables Used

- Optional (with defaults):
  - `project_name`, `environment`, `aws_region`
  - `aws_endpoint_override` (localstack/dev)
  - `table_name`
  - `partition_key_name`
  - `tags`

## Outputs

- `dynamodb_table_name`
- `dynamodb_table_arn`
- `dynamodb_partition_key`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
