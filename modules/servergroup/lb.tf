resource "yandex_lb_network_load_balancer" "lb" {
  name = "${var.group_prefix}-lb"

  listener {
    name = "http"
    port = 8080
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.servers.id
    healthcheck {
      name = "healthcheck"
        http_options {
          port = 8080
          path = "/"
        }
    }
  }
}

resource "yandex_lb_target_group" "servers" {
  name      = "${var.group_prefix}-${var.group_name}"

  dynamic "target" {
    for_each = yandex_compute_instance.testvm.*
    content {
      subnet_id = data.yandex_vpc_subnet.default_zone_subnet.id
      address   = target.value.network_interface[0].ip_address
    }
  }

}
