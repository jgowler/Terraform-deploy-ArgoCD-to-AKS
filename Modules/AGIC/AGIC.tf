resource "helm_release" "agic" {
  name             = "ingress-appgw"
  repository       = "oci://mcr.microsoft.com/azure-application-gateway/charts"
  chart            = "ingress-azure"
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
      value = "servicePrincipal"
    },
    {
      name  = "armAuth.identityClientId"
      value = var.agic_service_principal
    },
    {
      name  = "verbosityLevel"
      value = 3
    },
    {
      name = "appgw.ingressClass"
      value = "azure/application-gateway"
    }
  ]
}