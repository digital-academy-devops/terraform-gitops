resource "local_file" "hosts" {
  filename = "hosts-${var.group_prefix}-${var.group_name}"
  content  = <<EOT
[${var.group_name}]
%{for vm in yandex_compute_instance.testvm.*~}
${vm.network_interface[0].nat_ip_address}
%{endfor~}
EOT
}
