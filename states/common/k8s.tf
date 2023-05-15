data "yandex_vpc_network" "default" {
  network_id = "enp4avdfrvnj4hjf2aih"
}

data "yandex_vpc_subnet" "default" {
  count     = length(data.yandex_vpc_network.default.subnet_ids)
  subnet_id = data.yandex_vpc_network.default.subnet_ids[count.index]
}

locals {
  folder_id = data.terraform_remote_state.system.outputs.common-folder-id
  cloud_id  = data.terraform_remote_state.system.outputs.cloud-id
  version   = "1.23"
  sa_name   = "kube"
  zone1 = "ru-central1-a"
  zone2 = "ru-central1-b"
  
  k8s_sa_roles = [
    "k8s.clusters.agent",
    "vpc.publicAdmin",
    "container-registry.images.puller",
    "certificate-manager.certificates.downloader",
    "compute.viewer",
    "alb.editor",
    "load-balancer.admin",
    "dns.editor"
  ]
}

resource "yandex_kubernetes_cluster" "common" {
  name       = "course1"
  network_id = data.yandex_vpc_network.default.id
  master {
    version = local.version

    #regional {
    #  region = "ru-central1"
    #
    #  dynamic "location" {
    #    for_each = data.yandex_vpc_subnet.default.*
    #    content {
    #      zone      = location.value.zone
    #      subnet_id = location.value.subnet_id
    #    }
    #  }
    #}

    zonal {
      zone      = local.zone1
      subnet_id = [for subnet in data.yandex_vpc_subnet.default: subnet.id if subnet.zone == local.zone1 && startswith(subnet.name, "default-") ][0]
    }

    security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    public_ip          = true
  }
  service_account_id      = yandex_iam_service_account.k8s.id
  node_service_account_id = yandex_iam_service_account.k8s.id

  depends_on = [
    yandex_resourcemanager_cloud_iam_binding.cloud-bindings
  ]

  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }

}


resource "yandex_kubernetes_node_group" "standard-v2-zone1" {
  cluster_id  = yandex_kubernetes_cluster.common.id
  name        = "standard-v2-${local.zone1}"
  description = "description"
  version     = "1.23"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [for subnet in data.yandex_vpc_subnet.default: subnet.id if subnet.zone == local.zone1 && startswith(subnet.name, "default-") ]
      security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "docker"
    }
  }

  scale_policy {
    auto_scale {
      initial = 0
      max     = 2
      min     = 0
    }
  }

  allocation_policy {
    location {
      zone = local.zone1
    }
  }

}
  
resource "yandex_kubernetes_node_group" "standard-v2-zone2" {
  cluster_id  = yandex_kubernetes_cluster.common.id
  name        = "standard-v2-${local.zone2}"
  description = "description"
  version     = "1.23"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [for subnet in data.yandex_vpc_subnet.default: subnet.id if subnet.zone == local.zone2 && startswith(subnet.name, "default-") ]
      security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "docker"
    }
  }

  scale_policy {
    auto_scale {
      initial = 0
      max     = 2
      min     = 0
    }
  }

  allocation_policy {
    location {
      zone = local.zone2
    }
  }

}

resource "yandex_iam_service_account" "k8s" {
  name        = local.sa_name
  description = "K8S service account"
}
 
resource "yandex_resourcemanager_cloud_iam_binding" "cloud-bindings" {
  for_each = toset(local.k8s_sa_roles)
  cloud_id = local.cloud_id
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s.id}",
  ]
  role = each.key
}  

resource "yandex_kms_symmetric_key" "kms-key" {
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 year
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s.id}",
  ]
}

resource "yandex_vpc_security_group" "k8s-main-sg" {
  name       = "k8s-main-sg"
  network_id = data.yandex_vpc_network.default.id
  ingress {
    protocol          = "TCP"
    description       = "Allow healtchecks"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Allow internal communication"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol       = "ICMP"
    description    = "allow ICMP"
    v4_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    protocol       = "TCP"
    description    = "allow incoming nodeports connections"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
  ingress {
    protocol       = "TCP"
    description    = "Allow HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 443
  }
  egress {
    protocol       = "ANY"
    description    = "allow all"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

