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