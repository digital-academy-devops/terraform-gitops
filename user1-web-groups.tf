module "user1-web" {
  source = "./modules/servergroup"

  zone = local.zone
  instance_number = 3
  group_prefix = "user1"
  group_name = "web"
}