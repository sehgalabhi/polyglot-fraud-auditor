# Azure Identity Stack (Entra + Workload Federation)

This stack provisions Microsoft Entra identity resources and RBAC assignments for secretless access to Azure Event Hubs.

## Resources Created

- `azuread_application.workload`: Entra application
- `azuread_service_principal.workload`: service principal for runtime identity
- `azuread_application_federated_identity_credential.java`: federated credential for Java service account
- `azuread_application_federated_identity_credential.python`: federated credential for Python service account
- `azurerm_role_assignment.eventhubs_sender`: Event Hubs Data Sender role assignment
- `azurerm_role_assignment.eventhubs_receiver`: Event Hubs Data Receiver role assignment

## Variables Used

- Required:
  - `tenant_id`
  - `oidc_issuer_url`
  - `java_service_account_subject`
  - `python_service_account_subject`
  - `eventhubs_namespace_scope_id`
- Optional:
  - `subscription_id`
  - `project_name`
  - `environment`
  - `app_display_name`
  - `federated_audience`
  - `tags`

## Outputs

- `tenant_id`
- `application_client_id`
- `service_principal_object_id`
- `java_federated_credential_id`
- `python_federated_credential_id`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
