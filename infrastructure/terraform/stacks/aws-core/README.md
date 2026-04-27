# AWS application stacks

Terraform roots for AWS runtime resources live in subfolders (each folder is its own `terraform init` / state).

## Layout

- [`sqs/`](sqs/) — SQS alerts queue + dead-letter queue
- [`dynamodb/`](dynamodb/) — DynamoDB audit context table

## Apply order

1. `sqs`
2. `dynamodb`

Each subfolder has its own `README.md` and `terraform.tfvars.example`.
