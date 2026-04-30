locals {
  name_prefix = "${var.project_name}-${var.environment}"
  resolved_oidc_issuer_url = coalesce(
    var.oidc_issuer_url,
    data.terraform_remote_state.oke.outputs.oidc_issuer_url
  )
}

data "terraform_remote_state" "oke" {
  backend = "s3"

  config = {
    bucket = var.oke_state_bucket
    key    = var.oke_state_key
    region = var.oke_state_region
  }
}

resource "azuread_application" "workload" {
  display_name = "${local.name_prefix}-${var.app_display_name}"
}

resource "azuread_service_principal" "workload" {
  client_id = azuread_application.workload.client_id
}

resource "azuread_application_federated_identity_credential" "java" {
  application_id = azuread_application.workload.id
  display_name   = "${local.name_prefix}-java-federated"
  description    = "Federated identity for Java producer service account"
  audiences      = var.federated_audience
  issuer         = local.resolved_oidc_issuer_url
  subject        = var.java_service_account_subject
}

resource "azuread_application_federated_identity_credential" "python" {
  application_id = azuread_application.workload.id
  display_name   = "${local.name_prefix}-python-federated"
  description    = "Federated identity for Python auditor service account"
  audiences      = var.federated_audience
  issuer         = local.resolved_oidc_issuer_url
  subject        = var.python_service_account_subject
}
