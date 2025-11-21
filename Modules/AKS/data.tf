data "azurerm_user_assigned_identity" "pod_identity_appgw" {
  name                = "ingressapplicationgateway-${azurerm_kubernetes_cluster.aks.name}"
  resource_group_name = "MC_${var.resource_group_name}_${azurerm_kubernetes_cluster.aks.name}_${var.location}"
  depends_on = [
    azurerm_kubernetes_cluster.aks,
  ]
}
