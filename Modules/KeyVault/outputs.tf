output "keyvault_id" {
  value = azurerm_key_vault.kv-aks.id
}
output "keyvault_uri" {
  value = azurerm_key_vault.kv-aks.vault_uri
}