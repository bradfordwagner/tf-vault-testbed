## vars ########################################################
variable "config" {
  type = any
}
################################################################

## auth endpoints ##############################################
resource "vault_auth_backend" "kubernetes" {
  type      = "kubernetes"
  path      = "kubernetes/${var.config.auth.kubernetes.name}"
  tune {
    default_lease_ttl = "60s" # uses golang duration string
  }
}

resource "vault_auth_backend" "approle" {
  type      = "approle"
  path      = var.config.auth.approle.name
  tune {
    default_lease_ttl = "60s" # uses golang duration string
  }
}

resource "vault_auth_backend" "cert" {
  type      = "cert"
  path      = var.config.auth.cert.name
  tune {
    default_lease_ttl = "60s" # uses golang duration string
  }
}
################################################################
