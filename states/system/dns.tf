locals {
  default_folder_id = "b1gd1rrp2lk1onr8rfhk"
}

resource "yandex_dns_zone" "dacdevops" {
  name = "dacdevops"
  folder_id = local.default_folder_id

  zone   = "dacdevops.ru."
  public = true
}