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
  description = "AWS region for SQS resources."
  type        = string
  default     = "us-east-1"
}

variable "aws_endpoint_override" {
  description = "Optional AWS endpoint override (for localstack/dev)."
  type        = string
  default     = null
}

variable "alerts_queue_name" {
  description = "Main SQS alerts queue name."
  type        = string
  default     = "fraud-alerts"
}

variable "alerts_dlq_name" {
  description = "SQS dead-letter queue name."
  type        = string
  default     = "fraud-alerts-dlq"
}

variable "alerts_max_receive_count" {
  description = "Max receives before message goes to DLQ."
  type        = number
  default     = 5
}

variable "tags" {
  description = "Optional additional tags."
  type        = map(string)
  default     = {}
}
