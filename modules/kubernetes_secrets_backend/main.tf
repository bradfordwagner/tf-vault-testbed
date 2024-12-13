## variables ###################################################
variable "config" {
  type = any
}
################################################################

resource "vault_mount" "kubernetes_backends" {
  path                      = "kubernetes"
  type                      = "kubernetes"
  default_lease_ttl_seconds = var.config.secrets.kubernetes.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.config.secrets.kubernetes.max_lease_ttl_seconds
  options = {
    disable_local_ca_jwt = true
  }
}


resource "vault_kubernetes_secret_backend_role" "list_namespaces" {
  for_each = var.config.secrets.kubernetes.roles
  backend  = vault_mount.kubernetes_backends.id
  # follows a lowercase RFC 1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*')
  name                          = each.key
  allowed_kubernetes_namespaces = each.value.allowed_kubernetes_namespaces
  token_max_ttl                 = each.value.token_max_ttl
  # minimum of 10 minutes
  token_default_ttl    = each.value.token_default_ttl
  kubernetes_role_type = each.value.kubernetes_role_type
  generated_role_rules = each.value.generated_role_rules
}
