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
    owner = "georgiilebedev"
  }
}

output "glebedev-folder-id" {
  value = yandex_resourcemanager_folder.glebedev.id
}