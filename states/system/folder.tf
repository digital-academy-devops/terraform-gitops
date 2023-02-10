resource "yandex_resourcemanager_folder" "mostashkin" {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name = "mostashkin"
  labels = {
    owner = "mikhailostashkin"
    ttl = "1d"
    created_at = formatdate("YYYYMMDDhhmmss", timestamp())
  }
}

output "mostashkin-folder-id" {
  value = yandex_resourcemanager_folder.mostashkin.id
}