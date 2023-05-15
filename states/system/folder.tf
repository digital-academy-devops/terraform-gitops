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

resource "yandex_resourcemanager_folder" "zhuikov" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "zhuikov"
  labels = {
    owner = "gzhuikov"
  }
}

output "zhuikov-folder-id" {
  value = yandex_resourcemanager_folder.zhuikov.id
}
