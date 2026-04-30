# Azure Identity Stack (Entra + Workload Federation)

This stack provisions Microsoft Entra identity resources for secretless workload identity federation.

## Resources Created

- `azuread_application.workload`: Entra application
- `azuread_service_principal.workload`: service principal for runtime identity
- `azuread_application_federated_identity_credential.java`: federated credential for Java service account
- `azuread_application_federated_identity_credential.python`: federated credential for Python service account

## Variables Used

- Required:
  - `java_service_account_subject`
  - `python_service_account_subject`
- Optional:
  - `tenant_id`
  - `oidc_issuer_url` (manual override; otherwise read from OKE remote state)
  - `oke_state_bucket`, `oke_state_key`, `oke_state_region`
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
