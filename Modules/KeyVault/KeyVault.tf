data "azurerm_client_config" "current" {}

resource "random_string" "kv_suffix" {
  length = 6
  upper = false
  numeric = true
  special = false
}
resource "azurerm_key_vault" "this" {
  name                = "kv-argocd-${random_string.kv_suffix.result}"
  location            = var.location
  tenant_id           = var.tenant_id
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
}
resource "azurerm_key_vault_secret" "argocd_admin" {
  depends_on = [
    azurerm_key_vault.this
    ]

  name         = "argocdadmin"
  value        = var.argocd_admin
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_access_policy" "AKS" {
  depends_on = [
    azurerm_key_vault.this
    ]
  
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