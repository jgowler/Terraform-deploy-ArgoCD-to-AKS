output "kube_config" {
  value = {
    host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  }
}
output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
output "cluster_principal_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}