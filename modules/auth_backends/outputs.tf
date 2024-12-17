output "user_pass_accessor" {
  value = vault_auth_backend.userpass.accessor
}

output "cert_path" {
  value = vault_auth_backend.cert.path
}
