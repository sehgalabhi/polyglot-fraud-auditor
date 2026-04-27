#!/usr/bin/env bash
# Terraform orchestration for polyglot-fraud-auditor stacks.
# Requires: bash, terraform on PATH (override with TF=/path/to/terraform).
#
# Run from anywhere:
#   bash infrastructure/terraform/terraform-stacks.sh help
# Or from this directory:
#   ./terraform-stacks.sh help
#
# Optional non-interactive mode (CI / scripts):
#   export TF_CLI_ARGS_apply="-auto-approve"
#   export TF_CLI_ARGS_destroy="-auto-approve"

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TF="${TF:-terraform}"

BOOTSTRAP="bootstrap/aws-state"
AZ_RG="stacks/azure-core/resource-group"
AZ_EH="stacks/azure-core/eventhubs"
AZ_ID="stacks/azure-core/identity"
OCI="stacks/oci-core"
AWS_SQS="stacks/aws-core/sqs"
AWS_DDB="stacks/aws-core/dynamodb"
AWS_IAM="stacks/aws-core/iam-bedrock"

tf() {
  "$TF" -chdir="$ROOT/$1" "${@:2}"
}

usage() {
  cat <<'EOF'
Terraform stack orchestration (bash + terraform only).

  bash terraform-stacks.sh help

  bash terraform-stacks.sh init-all
  bash terraform-stacks.sh apply-bootstrap   # once, if you use S3 remote state
  bash terraform-stacks.sh apply-all         # Azure → OCI → AWS (not bootstrap)
  bash terraform-stacks.sh destroy-all       # AWS → OCI → Azure (NOT bootstrap)

  bash terraform-stacks.sh init-bootstrap | apply-bootstrap | destroy-bootstrap
  bash terraform-stacks.sh init-azure     | apply-azure     | destroy-azure
  bash terraform-stacks.sh init-oci       | apply-oci       | destroy-oci
  bash terraform-stacks.sh init-aws       | apply-aws       | destroy-aws

Bootstrap is excluded from destroy-all on purpose (shared state bucket).
Use destroy-bootstrap only when you intend to remove it.
EOF
}

cmd="${1:-help}"
shift || true

case "$cmd" in
  help|-h|--help)
    usage
    ;;

  init-bootstrap) tf "$BOOTSTRAP" init ;;
  apply-bootstrap) tf "$BOOTSTRAP" apply ;;
  destroy-bootstrap) tf "$BOOTSTRAP" destroy ;;

  init-azure)
    tf "$AZ_RG" init
    tf "$AZ_EH" init
    tf "$AZ_ID" init
    ;;
  apply-azure)
    tf "$AZ_RG" apply
    tf "$AZ_EH" apply
    tf "$AZ_ID" apply
    ;;
  destroy-azure)
    tf "$AZ_ID" destroy
    tf "$AZ_EH" destroy
    tf "$AZ_RG" destroy
    ;;

  init-oci) tf "$OCI" init ;;
  apply-oci) tf "$OCI" apply ;;
  destroy-oci) tf "$OCI" destroy ;;

  init-aws)
    tf "$AWS_SQS" init
    tf "$AWS_DDB" init
    tf "$AWS_IAM" init
    ;;
  apply-aws)
    tf "$AWS_SQS" apply
    tf "$AWS_DDB" apply
    tf "$AWS_IAM" apply
    ;;
  destroy-aws)
    tf "$AWS_IAM" destroy
    tf "$AWS_DDB" destroy
    tf "$AWS_SQS" destroy
    ;;

  init-all)
    tf "$BOOTSTRAP" init
    tf "$AZ_RG" init
    tf "$AZ_EH" init
    tf "$AZ_ID" init
    tf "$OCI" init
    tf "$AWS_SQS" init
    tf "$AWS_DDB" init
    tf "$AWS_IAM" init
    ;;
  apply-all)
    tf "$AZ_RG" apply
    tf "$AZ_EH" apply
    tf "$AZ_ID" apply
    tf "$OCI" apply
    tf "$AWS_SQS" apply
    tf "$AWS_DDB" apply
    tf "$AWS_IAM" apply
    ;;
  destroy-all)
    tf "$AWS_IAM" destroy
    tf "$AWS_DDB" destroy
    tf "$AWS_SQS" destroy
    tf "$OCI" destroy
    tf "$AZ_ID" destroy
    tf "$AZ_EH" destroy
    tf "$AZ_RG" destroy
    ;;

  *)
    echo "Unknown command: $cmd" >&2
    usage >&2
    exit 1
    ;;
esac
