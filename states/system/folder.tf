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