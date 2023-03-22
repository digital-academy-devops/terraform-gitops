output "ips" {
  value = flatten(yandex_compute_instance.testvm[*].network_interface[*].nat_ip_address)
}