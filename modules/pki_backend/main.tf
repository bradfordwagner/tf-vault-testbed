## variables ###################################################
variable "config" {
  type = any
}
################################################################

resource "vault_mount" "pki" {
  path                      = var.config.pki_backend.auth_endpoint
  type                      = "pki"
  default_lease_ttl_seconds = var.config.pki_backend.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.config.pki_backend.max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_role" "roles" {
  for_each = var.config.pki_backend.roles
  backend  = vault_mount.pki.path
  name     = each.key
  allowed_domains    = ["${each.value.identity}.${var.config.pki_backend.common_name}"]
  allow_subdomains   = false
  allow_bare_domains = true
  no_store           = true
}
