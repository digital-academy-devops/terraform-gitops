resource "yandex_dns_zone" "dacdevops" {
  name = "dacdevops"

  zone   = "dacdevops.ru."
  public = true
}