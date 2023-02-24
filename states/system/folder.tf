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