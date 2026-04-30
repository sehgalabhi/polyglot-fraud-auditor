provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "azuread" {
  # Uses active Azure CLI context by default.
  # Keep provider tenant dynamic unless you explicitly set one.
}
