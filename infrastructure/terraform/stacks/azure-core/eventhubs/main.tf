locals {
  default_tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
    stack       = "azure-eventhubs"
  }
}

resource "azurerm_eventhub_namespace" "main" {
  name                = var.eventhub_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.eventhub_namespace_sku
  capacity            = var.eventhub_namespace_capacity
  tags                = merge(local.default_tags, var.tags)
}

resource "azurerm_eventhub" "main" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_message_retention
}

resource "azurerm_eventhub_consumer_group" "auditor" {
  name                = var.consumer_group_name
  namespace_name      = azurerm_eventhub_namespace.main.name
  eventhub_name       = azurerm_eventhub.main.name
  resource_group_name = var.resource_group_name
}
