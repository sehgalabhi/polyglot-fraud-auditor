# AWS IAM + Bedrock permissions stack

This stack creates an IAM role and inline policy for the minimum app permissions: SQS (alerts + DLQ), DynamoDB audit table, and Bedrock `InvokeModel`.

## Resources Created

- `aws_iam_role.app`: workload IAM role
- `aws_iam_role_policy.app_inline`: inline policy (SQS + DynamoDB + Bedrock)

## Variables Used

- Required:
  - `alerts_queue_arn`
  - `alerts_dlq_arn`
  - `dynamodb_table_arn`
- Optional:
  - `project_name`, `environment`, `aws_region`, `tags`
  - `aws_endpoint_override` (localstack/dev)
  - `app_role_name`
  - `bedrock_model_arn` (if unset, allows all foundation models in the region — tighten for production)
  - `assume_role_policy_json` (if unset, trusts `ec2.amazonaws.com` for bootstrapping — replace for your real assume pattern)

## Outputs

- `app_role_name`
- `app_role_arn`
- `app_role_id`

## Apply order

1. Apply `aws-core/sqs` and `aws-core/dynamodb` first.
2. Copy queue and table ARNs into `terraform.tfvars` here.
3. `terraform init`, `plan`, `apply`.

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
