terraform {
  required_version = ">= 1.6.0"
  backend "s3" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}
