resource "random_string" "kvrand" {
  length  = 6
  numeric = true
  special = false
  upper   = false
  lower   = true
}
### Key Vault:
resource "azurerm_key_vault" "kv-aks" {
  name                = "kv-aks-${random_string.kvrand.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}
resource "azurerm_key_vault_access_policy" "kvp-aks" {
  key_vault_id = azurerm_key_vault.kv-aks.id
  tenant_id    = var.tenant_id
  object_id    = var.appgw_uai_id_pi

  secret_permissions = [
    "Get",
    "List",
    "Set"
  ]
}