output "Namespace" {
  value = kubernetes_namespace.ArgoCD.metadata[0].name
}