### Key Vault:
resource "azurerm_key_vault" "kv-aks" {
  name = "kv-aks"
  resource_group_name = var.resource_group_name
  location = var.location
  tenant_id = var.tenant_id
  sku_name = "standard"
}
resource "azurerm_key_vault_access_policy" "kvp-aks" {
  key_vault_id = azurerm_key_vault.kv-aks.id
  tenant_id = var.tenant_id
  object_id = var.cluster_principal_id

  secret_permissions = [
    "Get",
    "List",
    "Set"
  ]
}