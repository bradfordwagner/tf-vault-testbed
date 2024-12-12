## variables ###################################################
variable "config" {
  type = any
}
################################################################

# # https://developer.hashicorp.com/vault/tutorials/auth-methods/identity
resource "vault_identity_entity" "entity" {
  for_each = var.config.entities
  name     = each.key
  policies = each.value.policies
  metadata = each.value.metadata
}