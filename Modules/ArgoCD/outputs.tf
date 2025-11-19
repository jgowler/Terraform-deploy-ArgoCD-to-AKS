data "kubernetes_secret" "argocd_admin" {
  metadata {
    name      = "argocd-secret"
    namespace = var.namespace
  }

  depends_on = [
    helm_release.argocd
    ]
}

output "argocd_admin_password" {
  description = "Password for ArgoCD admin user"
  value       = base64decode(data.kubernetes_secret.argocd_admin.data["admin.password"])
  sensitive   = true
}
output "argocd_console_url" {
  value = "https://${var.appgw_public_ip_addr}"
}