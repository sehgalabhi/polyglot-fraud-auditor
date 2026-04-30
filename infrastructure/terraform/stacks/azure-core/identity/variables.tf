variable "subscription_id" {
  description = "Azure subscription ID. Leave null to use current authenticated context."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Optional Microsoft Entra tenant ID. Leave null to use current Azure CLI context."
  type        = string
  default     = null
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
  description = "Optional OIDC issuer URL override. Leave null to read from oci-core/oke remote state."
  type        = string
  default     = null
}

variable "oke_state_bucket" {
  description = "S3 bucket containing Terraform state for the oci-core/oke stack."
  type        = string
  default     = "polyglot-fraud-auditor-dev-922120356372-tfstate"
}

variable "oke_state_key" {
  description = "S3 object key for oci-core/oke stack state."
  type        = string
  default     = "dev/oci-core/oke/terraform.tfstate"
}

variable "oke_state_region" {
  description = "AWS region of the S3 backend storing oci-core/oke state."
  type        = string
  default     = "eu-north-1"
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
