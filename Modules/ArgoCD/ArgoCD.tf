resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  namespace  = var.namespace
  repository = var.argocd_repo

  set = [
    {
      name  = "server.service.type"
      value = "ClusterIP"
    },
    {
      name  = "server.ingress.enabled"
      value = "true"
    },
    {
      name  = "server.admin.password"
      value = var.admin_secret
    },
    {
      name  = "server.ingress.annotations.kubernetes\\.io/ingress.class"
      value = "azure/application-gateway"
    },
    {
      name  = "server.ingress.hosts[0].host"
      value = "argocd.example.com"
    },
    {
      name  = "server.ingress.hosts[0].paths[0]"
      value = "/"
    }
  ]
}