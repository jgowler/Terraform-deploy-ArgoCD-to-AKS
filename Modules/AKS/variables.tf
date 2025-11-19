variable "ssh_public_key" {
    type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "aks_subnet_id" {
  type = string
}
variable "common_tags" {
  type = map(string)
}
variable "appgw_id" {
  type = string
}