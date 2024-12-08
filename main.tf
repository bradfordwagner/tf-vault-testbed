provider "vault" {}

locals {
  config = yamldecode(file("${path.module}/config.yaml"))
}

module "auth" {
  source = "./modules/auth"
  config = local.config
}
