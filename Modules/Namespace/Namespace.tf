resource "kubernetes_namespace" "ArgoCD" {
  metadata {
    name = "ArgoCD"
  }
}