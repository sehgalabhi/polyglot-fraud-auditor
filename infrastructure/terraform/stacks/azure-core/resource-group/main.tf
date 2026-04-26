locals {
  default_tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
    stack       = "azure-core"
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(local.default_tags, var.tags)
}
