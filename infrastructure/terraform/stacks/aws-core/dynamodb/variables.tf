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
  description = "AWS region for DynamoDB."
  type        = string
  default     = "us-east-1"
}

variable "aws_endpoint_override" {
  description = "Optional AWS endpoint override (for localstack/dev)."
  type        = string
  default     = null
}

variable "table_name" {
  description = "Base name for the DynamoDB table (prefix with environment in main)."
  type        = string
  default     = "fraud-audit-context"
}

variable "partition_key_name" {
  description = "Partition key attribute name (string) for audit records."
  type        = string
  default     = "transactionId"
}

variable "tags" {
  description = "Optional additional tags."
  type        = map(string)
  default     = {}
}
