output "eventhub_namespace_name" {
  description = "Event Hubs namespace name."
  value       = azurerm_eventhub_namespace.main.name
}

output "eventhub_namespace_id" {
  description = "Event Hubs namespace ID."
  value       = azurerm_eventhub_namespace.main.id
}

output "eventhub_name" {
  description = "Event Hub name."
  value       = azurerm_eventhub.main.name
}

output "eventhub_id" {
  description = "Event Hub ID."
  value       = azurerm_eventhub.main.id
}

output "consumer_group_name" {
  description = "Event Hub consumer group name."
  value       = azurerm_eventhub_consumer_group.auditor.name
}
