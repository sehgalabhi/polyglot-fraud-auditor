# AWS application stacks

Terraform roots for AWS runtime resources live in subfolders (each folder is its own `terraform init` / state).

## Layout

- [`sqs/`](sqs/) — SQS alerts queue + dead-letter queue
- [`dynamodb/`](dynamodb/) — DynamoDB audit context table
- [`iam-bedrock/`](iam-bedrock/) — IAM role + inline policy (SQS, DynamoDB, Bedrock invoke)

## Apply order

1. `sqs`
2. `dynamodb`
3. `iam-bedrock` (paste queue and table ARNs from steps 1–2)

Each subfolder has its own `README.md` and `terraform.tfvars.example`.
