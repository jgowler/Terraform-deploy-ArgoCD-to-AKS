output "vault_uri" {
  value = azurerm_key_vault.this.vault_uri
}
output "id" {
  value = azurerm_key_vault.this.id
}
output "admin_secret" {
  value     = azurerm_key_vault_secret.argocd_admin.value
  sensitive = true
}