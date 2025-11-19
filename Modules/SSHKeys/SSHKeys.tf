### SSH key:
resource "tls_private_key" "public_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}