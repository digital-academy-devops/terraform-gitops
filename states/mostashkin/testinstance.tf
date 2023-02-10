#trigger4
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
    subnet_id = yandex_vpc_network.default.subnet_ids[0] #data.yandex_vpc_subnet.default_zone_subnet.id
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


resource "yandex_vpc_network" "default" {
  name = "default"
}