provider "vault" {}

locals {
  config = yamldecode(file("${path.module}/config.yaml"))
}

module "policies" {
  source = "./modules/policies"
}

module "auth_backends" {
  source = "./modules/auth_backends"
  config = local.config
}

module "entities" {
  source   = "./modules/entities"
  entities = local.config.entities
}

# setup user logins
module "users" {
  depends_on         = [module.auth_backends, module.entities]
  source             = "./modules/users"
  config             = local.config
  users              = local.config.users
  user_pass_accessor = module.auth_backends.user_pass_accessor
  entity_name_to_id  = module.entities.entity_name_to_id
}

module "groups" {
  source            = "./modules/groups"
  config            = local.config
  entity_name_to_id = module.entities.entity_name_to_id
}
