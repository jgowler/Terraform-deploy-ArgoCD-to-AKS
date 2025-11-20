### Providers:
provider "kubernetes" {
  alias                  = "aks"
  host                   = var.kubeconfig.host
  client_certificate     = base64decode(var.kubeconfig.client_certificate)
  client_key             = base64decode(var.kubeconfig.client_key)
  cluster_ca_certificate = base64decode(var.kubeconfig.cluster_ca_certificate)
}

provider "helm" {
  alias = "aks"
  kubernetes = {
    host                   = var.kubeconfig.host
    client_certificate     = base64decode(var.kubeconfig.client_certificate)
    client_key             = base64decode(var.kubeconfig.client_key)
    cluster_ca_certificate = base64decode(var.kubeconfig.cluster_ca_certificate)
  }
}
### ArgoCD
resource "helm_release" "argocd" {
  provider         = helm.aks
  name             = "argocd"
  chart            = var.argocd_repo
  namespace        = var.namespace
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
      name  = "server.service.type"
      value = "ClusterIP"
    },
    {
      name  = "server.ingress.tls" # Enable HTTP access for testing ONLY
      value = "[]"
    }
  ]
}

data "kubernetes_secret" "argocd_admin" {
  provider = kubernetes.aks
  metadata {
    name      = "argocd-secret"
    namespace = var.namespace
  }

  depends_on = [
    helm_release.argocd
  ]
}