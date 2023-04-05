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
}

resource "yandex_kubernetes_cluster" "k8s-regional" {
  name       = "course1"
  network_id = data.yandex_vpc_network.default.id
  master {
    version = local.version

    regional {
      region = "ru-central1"

      dynamic "location" {
        for_each = data.yandex_vpc_subnet.default.*
        content {
          zone      = location.value.zone
          subnet_id = location.value.subnet_id
        }
      }
    }

    security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    public_ip          = true
  }
  service_account_id      = yandex_iam_service_account.k8s.id
  node_service_account_id = yandex_iam_service_account.k8s.id

  depends_on = [
    yandex_resourcemanager_cloud_iam_binding.k8s-clusters-agent,
    yandex_resourcemanager_cloud_iam_binding.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]

  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }

  lifecycle {
    ignore_changes = [ master[0].regional[0] ]
  }
}

resource "yandex_kubernetes_node_group" "standard-v2-a" {
  cluster_id  = yandex_kubernetes_cluster.k8s-regional.id
  name        = "standard-v2"
  description = "description"
  version     = "1.23"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [for subnet in data.yandex_vpc_network.default: subnet.id if subnet.zone == "ru-central1-a" ]
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
      zone = "ru-central1-a"
    }
  }

}

resource "yandex_iam_service_account" "k8s" {
  name        = local.sa_name
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_cloud_iam_binding" "k8s-clusters-agent" {
  cloud_id = local.cloud_id
  role     = "k8s.clusters.agent"
  members  = ["serviceAccount:${yandex_iam_service_account.k8s.id}"]
}

resource "yandex_resourcemanager_cloud_iam_binding" "vpc-public-admin" {
  cloud_id = local.cloud_id
  role     = "vpc.publicAdmin"
  members  = ["serviceAccount:${yandex_iam_service_account.k8s.id}"]
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  folder_id = local.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
}

resource "yandex_resourcemanager_cloud_iam_binding" "alb-editor" {
  cloud_id = local.cloud_id
  role     = "alb.editor"
  members  = ["serviceAccount:${yandex_iam_service_account.k8s.id}"]
}

resource "yandex_resourcemanager_cloud_iam_binding" "certificate-downloader" {
  cloud_id = local.cloud_id
  role     = "certificate-manager.certificates.downloader"
  members  = ["serviceAccount:${yandex_iam_service_account.k8s.id}"]
}

resource "yandex_resourcemanager_cloud_iam_binding" "compute-viewer" {
  cloud_id = local.cloud_id
  role     = "compute.viewer"
  members  = ["serviceAccount:${yandex_iam_service_account.k8s.id}"]
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
    from_port      = 30000
    to_port        = 32767
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
