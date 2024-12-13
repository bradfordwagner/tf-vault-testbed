resource "vault_auth_backend" "userpass" {
  path = "userpass"
  type = "userpass"
}


# create kube auth backend
resource "vault_auth_backend" "kubernetes_auth_endpoint" {
  type      = "kubernetes"
  path      = var.config.kubernetes.cluster.auth_endpoint
  tune {
    default_lease_ttl = var.config.kubernetes.cluster.default_lease_ttl
  }
}

resource "vault_kubernetes_auth_backend_role" "smoke_test" {
  for_each = var.config.kubernetes.roles
  role_name                        = each.key
  backend                          = vault_auth_backend.kubernetes_auth_endpoint.path
  bound_service_account_names      = each.value.kubernetes.service_account_names
  bound_service_account_namespaces = each.value.kubernetes.namespaces
  token_policies = each.value.token_policies
  alias_name_source = "serviceaccount_name"
}

