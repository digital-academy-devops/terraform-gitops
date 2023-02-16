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
    subnet_id = data.terraform_remote_state.system.outputs.default-subnets[0]
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("testinstance.pub")}"
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

resource "yandex_vpc_subnet" "subnet-a" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
}