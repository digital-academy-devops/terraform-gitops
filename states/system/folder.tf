resource "yandex_resourcemanager_folder" "common" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "common"
}

output "common-folder-id" {
  value = yandex_resourcemanager_folder.common.id
}


resource "yandex_resourcemanager_folder" "mostashkin" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "mostashkin"
  labels = {
    owner = "mikhailostashkin"
  }
}

output "mostashkin-folder-id" {
  value = yandex_resourcemanager_folder.mostashkin.id
}

resource "yandex_resourcemanager_folder" "glebedev" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "glebedev"
  labels = {
    owner = "lebedevgeorgii"
  }
}

output "glebedev-folder-id" {
  value = yandex_resourcemanager_folder.glebedev.id
}

resource "yandex_resourcemanager_folder" "robonen" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "robonen"
  labels = {
    owner = "andrewrobonen"
  }
}

output "robonen-folder-id" {
  value = yandex_resourcemanager_folder.robonen.id
}

resource "yandex_resourcemanager_folder" "amalkov" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "amalkov"
  labels = {
    owner = "malkovanton"
  }
}

output "amalkov-folder-id" {
  value = yandex_resourcemanager_folder.amalkov.id
}

resource "yandex_resourcemanager_folder" "vbystritskiy" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "vbystritskiy"
  labels = {
    owner = "vasilybystritskiy"
  }
}

output "vbystritskiy-folder-id" {
  value = yandex_resourcemanager_folder.vbystritskiy.id
}

resource "yandex_resourcemanager_folder" "akupriyanov" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "akupriyanov"
  labels = {
    owner = "andreykupriyanov"
  }
}

output "akupriyanov-folder-id" {
  value = yandex_resourcemanager_folder.akupriyanov.id
}

resource "yandex_resourcemanager_folder" "pmironenko" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "pmironenko"
  labels = {
    owner = "pavelmironenko"
  }
}

output "pmironenko-folder-id" {
  value = yandex_resourcemanager_folder.pmironenko.id
}

resource "yandex_resourcemanager_folder" "eostrovatikova" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "eostrovatikova"
  labels = {
    owner = "elizavetaostrovatikova"
  }
}

output "eostrovatikova-folder-id" {
  value = yandex_resourcemanager_folder.eostrovatikova.id
}

resource "yandex_resourcemanager_folder" "alin" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "alin"
  labels = {
    owner = "andreyalin"
  }
}

output "alin-folder-id" {
  value = yandex_resourcemanager_folder.alin.id
}

resource "yandex_resourcemanager_folder" "mulenokv" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "mulenokv"
  labels = {
    owner = "mulenokivan"
  }
}

output "mulenokv-folder-id" {
  value = yandex_resourcemanager_folder.mulenokv.id
}

resource "yandex_resourcemanager_folder" "hzhuikov" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "hzhuikov"
  labels = {
    owner = "hermanzhuikov"
  }
}

output "hzhuikov-folder-id" {
  value = yandex_resourcemanager_folder.hzhuikov.id
}

resource "yandex_resourcemanager_folder" "shpagin" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "shpagin"
  labels = {
    owner = "evgenyshpagin"
  }
}

output "shpagin-folder-id" {
  value = yandex_resourcemanager_folder.shpagin.id
}

resource "yandex_resourcemanager_folder" "sheverev" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "sheverev"
  labels = {
    owner = "vladislavsheverev"
  }
}

output "sheverev-folder-id" {
  value = yandex_resourcemanager_folder.sheverev.id
}

resource "yandex_resourcemanager_folder" "abekrenev" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "abekrenev"
  labels = {
    owner = "aleksandrbekrenev"
  }
}

output "abekrenev-folder-id" {
  value = yandex_resourcemanager_folder.abekrenev.id
}

resource "yandex_resourcemanager_folder" "idenisov" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "idenisov"
  labels = {
    owner = "ilyadenisov"
  }
}

output "idenisov-folder-id" {
  value = yandex_resourcemanager_folder.idenisov.id
}

resource "yandex_resourcemanager_folder" "zhportnyagin" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "zhportnyagin"
  labels = {
    owner = "zportnyagin"
  }
}

output "zhportnyagin-folder-id" {
  value = yandex_resourcemanager_folder.zhportnyagin.id
}
