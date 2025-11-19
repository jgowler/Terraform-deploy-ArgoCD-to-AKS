provider "helm" {
  kubernetes = {
    host                   = var.kubeconfig.host
    client_certificate     = base64decode(var.kubeconfig.client_certificate)
    client_key             = base64decode(var.kubeconfig.client_key)
    cluster_ca_certificate = base64decode(var.kubeconfig.cluster_ca_certificate)
  }
}
### ArgoCD
resource "helm_release" "argocd" {
  name = "argocd"
  chart = var.argocd_repo
  namespace = var.namespace
  create_namespace = true

  set = [
  {
    name  = "server.ingress.enabled"
    value = "true"
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
  },
  {
    name = "server.service.type"
    value = "ClusterIP"
  },
  { 
    name = "server.ingress.enabled"
    value = "true"
  }
]
}