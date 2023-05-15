
resource "yandex_resourcemanager_folder" "Herman7883 {
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  name     = "Herman7883"
  labels = {
    owner = "hermanzh"
  }
}

output "Herman7883-folder-id" {
  value = yandex_resourcemanager_folder.Herman7883.id
}