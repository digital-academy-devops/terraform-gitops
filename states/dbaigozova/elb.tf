resource "yandex_lb_network_load_balancer" "lb" {
  name = "${local.group_prefix}-lb"

  listener {
    name = "http"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.servers.id
    healthcheck {
      name = "healthcheck"
        http_options {
          port = 80
          path = "/"
        }
    }
  }
}

resource "yandex_lb_target_group" "servers" {
  name      = "${local.group_prefix}-tg"

  dynamic "target" {
    for_each = yandex_compute_instance.testvm.*
    content {
      subnet_id = data.terraform_remote_state.system.outputs.default-subnets[2]
      address   = target.value.network_interface[0].ip_address
    }
  }

}
