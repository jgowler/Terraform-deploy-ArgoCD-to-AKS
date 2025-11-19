variable "kubeconfig" {
  description = "AKS kubeconfig"
  type = object({
    host                   = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
  })
}
variable "argocd_repo" {
  type = string
}
variable "namespace" {
  type = string
}
variable "appgw_public_ip_addr" {
  type = string
}