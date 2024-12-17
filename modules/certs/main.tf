## variables ###################################################
variable "config" {
  type = any
}

variable "cert_path" {
  type = string
}

################################################################
resource "vault_cert_auth_backend_role" "cert" {
  allowed_common_names = each.value.allowed_common_names
  backend              = var.cert_path
  certificate          = file("~/.vault-ca")
  display_name         = each.key
  for_each             = var.config.cert.roles
  name                 = each.key
  token_type           = each.value.token_type
  # token_ttl            = 300
  # token_max_ttl        = 600
  # token_policies       = ["foo"]
}

