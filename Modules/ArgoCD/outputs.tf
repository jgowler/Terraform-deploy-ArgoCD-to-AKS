output "argocd_admin_password" {
  description = "Password for ArgoCD admin user"
  value       = data.kubernetes_secret.argocd_admin.data["admin.password"]
  sensitive   = true
}
output "argocd_console_url" {
  value = "https://${var.appgw_public_ip_addr}"
}