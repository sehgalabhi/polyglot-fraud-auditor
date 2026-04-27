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
  description = "Compartment OCID where network resources are created."
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

variable "vcn_cidr" {
  description = "CIDR block for the OCI VCN."
  type        = string
  default     = "10.40.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet (LB/API access)."
  type        = string
  default     = "10.40.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet (reserved for future private-node setup)."
  type        = string
  default     = "10.40.2.0/24"
}

variable "freeform_tags" {
  description = "Optional freeform tags applied to OCI resources."
  type        = map(string)
  default     = {}
}
