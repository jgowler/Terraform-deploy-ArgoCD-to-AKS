data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = "kv-argocd"
  location            = var.location
  tenant_id           = var.tenant_id
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_key_vault_access_policy" "AKS" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = var.tenant_id
  object_id    = var.aks_service_principal

  key_permissions = [
    "Get"
  ]
  secret_permissions = [
    "Get"
  ]
}