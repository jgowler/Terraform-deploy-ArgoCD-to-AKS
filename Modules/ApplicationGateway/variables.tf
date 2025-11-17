variable "resource_group_name" {
  description = "Resource Group in subscription"
  type        = string
}
variable "location" {
  type = string
}
variable "common_tags" {
  type = map(string)
}
variable "vnet_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "public_ip_id" {
  type = string
}