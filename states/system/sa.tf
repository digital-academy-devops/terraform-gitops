module "terraform-sa" {
  source = "./modules/service-account"
  name = "terraform"
  folder_id = data.yandex_resourcemanager_folder.do-course-1-default.id
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  roles = [
    "compute.admin",
    "resource-manager.editor",
    "iam.serviceAccounts.admin",
    "storage.editor",
  ]
}

module "terraform-viewer-sa" {
  source = "./modules/service-account"
  name = "terraform-viewer"
  folder_id = data.yandex_resourcemanager_folder.do-course-1-default.id
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
  roles = [
    "compute.viewer",
    "resource-manager.viewer",
    "storage.viewer",
  ]
}
