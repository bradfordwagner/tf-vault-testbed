provider "vault" {}

locals {
  config = yamldecode(file("${path.module}/config.yaml"))
}

module "policies" {
  source = "./modules/policies"
  config = local.config
}

module "entities" {
  source = "./modules/entities"
  config = local.config
}

module "groups" {
  source = "./modules/groups"
  config = local.config
}

module "auth" {
  source = "./modules/auth_backends"
  config = local.config
}
