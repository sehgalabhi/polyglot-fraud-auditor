variable "subscription_id" {
  description = "Azure subscription ID. Leave null to use current authenticated context."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the resource group."
  type        = string
  default     = "northeurope"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
}

variable "project_name" {
  description = "Project name used for standard tags."
  type        = string
  default     = "polyglot-fraud-auditor"
}

variable "environment" {
  description = "Environment label (for example: dev, stage, prod)."
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Optional additional tags."
  type        = map(string)
  default     = {}
}
