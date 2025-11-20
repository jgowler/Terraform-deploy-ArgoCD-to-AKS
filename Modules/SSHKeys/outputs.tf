output "ssh_public_key" {
  value = tls_private_key.public_key.public_key_openssh
}
output "ssh_private_key" {
  sensitive = true
  value     = tls_private_key.public_key.private_key_openssh
}