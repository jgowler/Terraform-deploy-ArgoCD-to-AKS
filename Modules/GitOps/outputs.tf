output "bootstrap_app_name" {
  value = kubernetes_manifest.bootstrap.metadata[0].name
}