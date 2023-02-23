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