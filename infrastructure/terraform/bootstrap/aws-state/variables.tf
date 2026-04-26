variable "project_name" {
  description = "Project identifier used in resource names."
  type        = string
}

variable "environment" {
  description = "Environment identifier (for example: dev, stage, prod)."
  type        = string
}

variable "aws_region" {
  description = "AWS region for bootstrap resources."
  type        = string
}

variable "state_bucket_force_destroy" {
  description = "Allow deleting the state bucket even when it still contains objects."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Extra tags applied to all bootstrap resources."
  type        = map(string)
  default     = {}
}
