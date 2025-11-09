output "namespace" {
  value = kubernetes_namespace.argocd.metadata[0].name
}
output "server_service" {
  value = kubernetes_service.argocd_server.metadata[0].name
}