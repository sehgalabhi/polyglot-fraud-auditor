variable "project_name" {
  description = "Project name used for default tags."
  type        = string
  default     = "polyglot-fraud-auditor"
}

variable "environment" {
  description = "Environment label (for example: dev, stage, prod)."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region (used in Bedrock resource ARNs when not fully specified)."
  type        = string
  default     = "us-east-1"
}

variable "aws_endpoint_override" {
  description = "Optional AWS endpoint override (for localstack/dev)."
  type        = string
  default     = null
}

variable "app_role_name" {
  description = "IAM role name for the fraud auditor workload."
  type        = string
  default     = "fraud-auditor-app-role"
}

variable "alerts_queue_arn" {
  description = "ARN of the main SQS alerts queue (from aws-core/sqs stack output)."
  type        = string
}

variable "alerts_dlq_arn" {
  description = "ARN of the SQS dead-letter queue (from aws-core/sqs stack output)."
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the audit context DynamoDB table (from aws-core/dynamodb stack output)."
  type        = string
}

variable "bedrock_model_arn" {
  description = "Bedrock foundation model ARN for InvokeModel. If null, allows all foundation models in this region (broader; tighten for production)."
  type        = string
  default     = null
}

variable "assume_role_policy_json" {
  description = "JSON trust policy for who can assume this role. Override for OIDC/IRSA or your identity pattern."
  type        = string
  default     = null
}

variable "tags" {
  description = "Optional additional tags."
  type        = map(string)
  default     = {}
}
