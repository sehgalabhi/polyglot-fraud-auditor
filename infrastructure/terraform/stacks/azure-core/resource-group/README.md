# Azure Resource Group Stack

This stack provisions the Azure Resource Group foundation for the project.

## Resources Created

- `azurerm_resource_group.main`: Azure Resource Group

## Variables Used

- Required:
  - `resource_group_name`
- Optional:
  - `subscription_id` (uses current `az` auth context when null)
  - `location` (default: `northeurope`)
  - `project_name`
  - `environment`
  - `tags`

## Outputs

- `resource_group_name`
- `resource_group_id`
- `resource_group_location`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
