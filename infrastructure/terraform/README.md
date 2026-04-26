# Terraform Infrastructure

This directory contains Terraform code for cloud infrastructure in phased rollouts.

## Phase 1: AWS State Bootstrap

The first stack creates shared remote-state primitives in AWS:
- S3 bucket for Terraform state
- DynamoDB table for Terraform state locking

Location: `bootstrap/aws-state/`

### 1) Prepare values

```bash
cd bootstrap/aws-state
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your environment values.

### 2) Initialize, plan, and apply

```bash
terraform init
terraform plan
terraform apply
```

### 3) Capture outputs

After apply, note:
- `terraform_state_bucket_name`
- `terraform_lock_table_name`
- `aws_region`

These are used by all future stacks (AWS and Azure) through an S3 backend.

### 4) Configure remote backend in future stacks

Use an environment-specific backend file from `environments/`:

```bash
# Example:
cp ../../environments/dev.backend.hcl.example ../../environments/dev.backend.hcl
terraform init -backend-config=../../environments/dev.backend.hcl
```

If a stack started with local state, migrate it with:

```bash
terraform init -migrate-state -backend-config=../../environments/dev.backend.hcl
```

## Directory Layout

- `bootstrap/aws-state/`: creates S3 + DynamoDB backend resources
- `environments/`: backend configuration templates for each environment
