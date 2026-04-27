variable "subscription_id" {
  description = "Azure subscription ID. Leave null to use current authenticated context."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string
}

variable "project_name" {
  description = "Project name used in display names and tags."
  type        = string
  default     = "polyglot-fraud-auditor"
}

variable "environment" {
  description = "Environment label (for example: dev, stage, prod)."
  type        = string
  default     = "dev"
}

variable "app_display_name" {
  description = "Display name for the Entra application."
  type        = string
  default     = "polyglot-fraud-auditor-workload"
}

variable "oidc_issuer_url" {
  description = "OIDC issuer URL for OCI/OKE workload identity federation."
  type        = string
}

variable "federated_audience" {
  description = "Audience used for federated credentials."
  type        = list(string)
  default     = ["api://AzureADTokenExchange"]
}

variable "java_service_account_subject" {
  description = "Kubernetes subject for Java service account (system:serviceaccount:<ns>:<sa>)."
  type        = string
}

variable "python_service_account_subject" {
  description = "Kubernetes subject for Python service account (system:serviceaccount:<ns>:<sa>)."
  type        = string
}

variable "tags" {
  description = "Optional additional tags for metadata outputs/documentation."
  type        = map(string)
  default     = {}
}
