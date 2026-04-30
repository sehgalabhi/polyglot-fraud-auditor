#!/usr/bin/env bash
# Destroy helper for all Terraform stacks in safe reverse dependency order.
# Requires: bash, terraform on PATH (override with TF=/path/to/terraform).
#
# Usage:
#   bash infrastructure/terraform/terraform-destroy-all.sh
#   bash infrastructure/terraform/terraform-destroy-all.sh --yes
#   bash infrastructure/terraform/terraform-destroy-all.sh --yes --include-bootstrap
#
# Notes:
# - By default, bootstrap/aws-state is NOT destroyed.
# - Use --include-bootstrap only if you intentionally want to remove
#   Terraform backend resources (S3 bucket + DynamoDB lock table).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TF="${TF:-terraform}"

BOOTSTRAP="bootstrap/aws-state"
AZ_RG="stacks/azure-core/resource-group"
AZ_ID="stacks/azure-core/identity"
OCI_NETWORK="stacks/oci-core/network"
OCI_OKE="stacks/oci-core/oke"
AWS_SQS="stacks/aws-core/sqs"
AWS_DDB="stacks/aws-core/dynamodb"

AUTO_APPROVE=false
INCLUDE_BOOTSTRAP=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --yes|-y)
      AUTO_APPROVE=true
      shift
      ;;
    --include-bootstrap)
      INCLUDE_BOOTSTRAP=true
      shift
      ;;
    --help|-h)
      cat <<'EOF'
Destroy all stacks in reverse order:
  AWS DynamoDB -> AWS SQS -> OCI OKE -> OCI Network -> Azure Identity -> Azure Resource Group

Options:
  --yes, -y             Skip interactive confirmation prompt.
  --include-bootstrap   Also destroy bootstrap/aws-state at the end.
  --help, -h            Show this help.
EOF
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

tf() {
  "$TF" -chdir="$ROOT/$1" "${@:2}"
}

destroy_stack() {
  local stack="$1"
  echo ">>> Destroying $stack"
  tf "$stack" destroy
}

if [[ "$AUTO_APPROVE" == true ]]; then
  export TF_CLI_ARGS_destroy="${TF_CLI_ARGS_destroy:-} -auto-approve"
fi

if [[ "$AUTO_APPROVE" == false ]]; then
  echo "This will destroy resources in reverse dependency order:"
  echo "  1) $AWS_DDB"
  echo "  2) $AWS_SQS"
  echo "  3) $OCI_OKE"
  echo "  4) $OCI_NETWORK"
  echo "  5) $AZ_ID"
  echo "  6) $AZ_RG"
  if [[ "$INCLUDE_BOOTSTRAP" == true ]]; then
    echo "  7) $BOOTSTRAP (INCLUDED)"
  else
    echo "  7) $BOOTSTRAP (SKIPPED)"
  fi
  read -r -p "Continue? Type 'yes' to proceed: " confirm
  if [[ "$confirm" != "yes" ]]; then
    echo "Cancelled."
    exit 0
  fi
fi

destroy_stack "$AWS_DDB"
destroy_stack "$AWS_SQS"
destroy_stack "$OCI_OKE"
destroy_stack "$OCI_NETWORK"
destroy_stack "$AZ_ID"
destroy_stack "$AZ_RG"

if [[ "$INCLUDE_BOOTSTRAP" == true ]]; then
  destroy_stack "$BOOTSTRAP"
else
  echo ">>> Skipping $BOOTSTRAP (default safety behavior)"
fi

echo "Destroy workflow complete."
