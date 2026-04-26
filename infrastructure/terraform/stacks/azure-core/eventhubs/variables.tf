variable "subscription_id" {
  description = "Azure subscription ID. Leave null to use current authenticated context."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "Name of the existing Azure resource group."
  type        = string
}

variable "location" {
  description = "Azure region for Event Hubs namespace."
  type        = string
}

variable "eventhub_namespace_name" {
  description = "Event Hubs namespace name."
  type        = string
}

variable "eventhub_namespace_sku" {
  description = "Event Hubs namespace SKU (Basic, Standard, Premium)."
  type        = string
  default     = "Standard"
}

variable "eventhub_namespace_capacity" {
  description = "Throughput units for Event Hubs namespace."
  type        = number
  default     = 1
}

variable "eventhub_name" {
  description = "Event Hub name."
  type        = string
}

variable "eventhub_partition_count" {
  description = "Number of partitions for the Event Hub."
  type        = number
  default     = 2
}

variable "eventhub_message_retention" {
  description = "Message retention in days."
  type        = number
  default     = 1
}

variable "consumer_group_name" {
  description = "Consumer group name for auditor consumption."
  type        = string
  default     = "auditor"
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
