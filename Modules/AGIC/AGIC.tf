resource "helm_release" "agic" {
  name             = "ingress-appgw"
  repository       = var.repository
  chart            = "azure-application-gateway-kubernetes-ingress"
  namespace        = "agic-namespace"
  create_namespace = true

  set = [
    {
      name  = "appgw.name"
      value = var.appgw_name
    },
    {
      name  = "appgw.resourceGroup"
      value = var.resource_group_name
    },
    {
      name  = "armAuth.type"
      value = "managedIdentity"
    },
    {
      name  = "armAuth.identityId"
      value = var.aks_service_principal
    },
    {
      name  = "verbosityLevel"
      value = 3
    }
  ]
}