output "hostname" {
  value = kubernetes_ingress.argocd_ingress.status[0].load_balancer[0].ingress[0].hostname
}