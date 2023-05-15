locals {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "testvm" {
  name        = "testinstance"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = data.terraform_remote_state.system.outputs.default-subnets[2]
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("yc.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

}

data "yandex_compute_image" "my_image" {
  family = "ubuntu-2204-lts"
}