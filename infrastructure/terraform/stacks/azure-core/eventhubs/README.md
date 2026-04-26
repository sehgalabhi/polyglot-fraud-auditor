# Azure Event Hubs Stack

This stack provisions Azure Event Hubs resources in an existing resource group.

## Resources Created

- `azurerm_eventhub_namespace.main`: Event Hubs namespace
- `azurerm_eventhub.main`: Event Hub
- `azurerm_eventhub_consumer_group.auditor`: Consumer group for auditor service

## Variables Used

- Required:
  - `resource_group_name`
  - `location`
  - `eventhub_namespace_name`
  - `eventhub_name`
- Optional:
  - `subscription_id` (uses current `az` auth context when null)
  - `eventhub_namespace_sku` (default: `Standard`)
  - `eventhub_namespace_capacity` (default: `1`)
  - `eventhub_partition_count` (default: `2`)
  - `eventhub_message_retention` (default: `1`)
  - `consumer_group_name` (default: `auditor`)
  - `project_name`
  - `environment`
  - `tags`

## Outputs

- `eventhub_namespace_name`
- `eventhub_namespace_id`
- `eventhub_name`
- `eventhub_id`
- `consumer_group_name`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
