output "argocd_admin_password" {
  value = module.ArgoCD.argocd_admin_password
  sensitive = true
}