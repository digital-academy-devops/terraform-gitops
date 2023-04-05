resource "yandex_dns_zone" "course1" {
  name        = "dac-course-1"

  zone    = "course1.dactusur.ru."
  public  = true
}
