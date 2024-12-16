resource "vault_policy" "ui" {
  name   = "ui"
  policy = <<EOT
path "*" {
  capabilities = ["read", "list"]
}
EOT
}

# read any oidc client
resource "vault_policy" "argo_workflows_oidc_client" {
  name   = "argo_workflows_oidc_client"
  policy = <<EOT
path "identity/oidc/client/argo-workflows" {
  capabilities = ["read"]
}
EOT
}

# list_pods policy
resource "vault_policy" "list_pods" {
  name   = "list_pods"
  policy = <<EOT
path "kubernetes/creds/list_pods" {
  capabilities = ["update"]
}
EOT
}
