output "tenant_id" {
  description = "Microsoft Entra tenant ID used by this stack."
  value       = var.tenant_id
}

output "application_client_id" {
  description = "Client ID of the Entra application."
  value       = azuread_application.workload.client_id
}

output "service_principal_object_id" {
  description = "Object ID of the service principal."
  value       = azuread_service_principal.workload.object_id
}

output "java_federated_credential_id" {
  description = "Federated identity credential ID for Java service account."
  value       = azuread_application_federated_identity_credential.java.id
}

output "python_federated_credential_id" {
  description = "Federated identity credential ID for Python service account."
  value       = azuread_application_federated_identity_credential.python.id
}
