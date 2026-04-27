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
- `stacks/aws-core/`: AWS application stacks (`sqs`, `dynamodb`, `iam-bedrock`); each subfolder is a separate Terraform root

## Stack orchestration (shell script)

No `make` required—only `bash` and `terraform` on your `PATH`.

From the repo root:

```bash
bash infrastructure/terraform/terraform-stacks.sh help
bash infrastructure/terraform/terraform-stacks.sh init-all
bash infrastructure/terraform/terraform-stacks.sh apply-bootstrap   # once, if you use the S3 remote state bucket
bash infrastructure/terraform/terraform-stacks.sh apply-all       # Azure → OCI → AWS (each stack needs its own terraform.tfvars)
bash infrastructure/terraform/terraform-stacks.sh destroy-all     # destroys AWS → OCI → Azure (does not destroy bootstrap)
```

Or `cd infrastructure/terraform` and run `./terraform-stacks.sh …` (ensure the file is executable: `chmod +x terraform-stacks.sh`).

`destroy-all` intentionally skips `bootstrap/aws-state` so you do not delete the shared state bucket by mistake. Use `destroy-bootstrap` only when you intend to remove it.

For non-interactive runs (e.g. CI), you can set:

```bash
export TF_CLI_ARGS_apply="-auto-approve"
export TF_CLI_ARGS_destroy="-auto-approve"
```
