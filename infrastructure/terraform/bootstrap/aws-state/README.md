# AWS State Bootstrap

This stack provisions shared Terraform backend resources in AWS.

## Resources Created

- `aws_s3_bucket.state_bucket`: S3 bucket used for Terraform remote state
- `aws_s3_bucket_versioning.state_bucket_versioning`: enables bucket versioning
- `aws_s3_bucket_server_side_encryption_configuration.state_bucket_encryption`: enables SSE (AES256)
- `aws_s3_bucket_public_access_block.state_bucket_public_access_block`: blocks all public access
- `aws_s3_bucket_policy.state_bucket_policy`: enforces HTTPS-only bucket access
- `aws_s3_bucket_ownership_controls.state_bucket_ownership`: sets bucket owner enforced ownership
- `aws_dynamodb_table.state_lock_table`: lock table for Terraform state operations

## Variables Used

- Required:
  - `project_name`
  - `environment`
  - `aws_region`
- Optional:
  - `state_bucket_force_destroy` (default: `false`)
  - `tags` (map of extra tags)

## Outputs

- `terraform_state_bucket_name`
- `terraform_lock_table_name`
- `aws_region`
- `backend_hcl_template`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
