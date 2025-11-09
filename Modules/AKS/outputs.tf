output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}
output "cluster_name" {
  value = azurerm_kubernetes_cluster.this.name
}
output "cluster_location" {
  value = azurerm_kubernetes_cluster.this.location
}
output "aks_service_principal" {
  value = azurerm_kubernetes_cluster.this.identity[0].principal_id
}
