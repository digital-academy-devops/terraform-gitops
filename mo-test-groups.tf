locals {
  zone = "ru-central1-a"
}

module "mo-server-group" {
  source = "./modules/servergroup"

  zone = local.zone
  instance_number = 1
  group_prefix = "mo"
  group_name = "appservers"
  image_name = "appserver"
}