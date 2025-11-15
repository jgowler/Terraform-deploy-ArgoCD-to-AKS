output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}
output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}
output "cluster_location" {
  value = azurerm_kubernetes_cluster.aks_cluster.location
}
output "aks_service_principal" {
  value = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}
