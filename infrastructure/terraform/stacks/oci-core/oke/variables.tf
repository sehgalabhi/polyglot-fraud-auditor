variable "tenancy_ocid" {
  description = "OCI tenancy OCID."
  type        = string
}

variable "user_ocid" {
  description = "OCI user OCID used by Terraform."
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint for the OCI API key."
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key used for OCI API signing."
  type        = string
}

variable "region" {
  description = "OCI region where resources are provisioned."
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID where OKE resources are created."
  type        = string
}

variable "project_name" {
  description = "Project name used in resource display names."
  type        = string
  default     = "polyglot-fraud-auditor"
}

variable "environment" {
  description = "Deployment environment (for example: dev, stage, prod)."
  type        = string
  default     = "dev"
}

variable "network_state_bucket" {
  description = "S3 bucket containing Terraform state for the oci-core/network stack."
  type        = string
  default     = "polyglot-fraud-auditor-dev-922120356372-tfstate"
}

variable "network_state_key" {
  description = "S3 object key for oci-core/network stack state."
  type        = string
  default     = "dev/oci-core/network/terraform.tfstate"
}

variable "network_state_region" {
  description = "AWS region of the S3 backend storing oci-core/network state."
  type        = string
  default     = "eu-north-1"
}

variable "kubernetes_version" {
  description = "Optional Kubernetes version for OKE cluster/node pool. Null lets OCI choose defaults."
  type        = string
  default     = null
}

variable "node_pool_size" {
  description = "Number of worker nodes in the OKE node pool."
  type        = number
  default     = 1
}

variable "node_shape" {
  description = "Compute shape used for OKE worker nodes."
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "node_ocpus" {
  description = "OCPU count for flex worker node shape."
  type        = number
  default     = 2
}

variable "node_memory_gbs" {
  description = "Memory in GB for flex worker node shape."
  type        = number
  default     = 12
}

variable "freeform_tags" {
  description = "Optional freeform tags applied to OCI resources."
  type        = map(string)
  default     = {}
}
