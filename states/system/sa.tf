module "terraform-sa" {
  source    = "./modules/service-account"
  name      = "terraform"
  folder_id = data.yandex_resourcemanager_folder.do-course-1-default.id
  cloud_id  = data.yandex_resourcemanager_cloud.do-course-1.id
  roles = [
    "compute.admin",
    "resource-manager.admin",
    "iam.admin",
    "storage.editor",
    "vpc.admin",
    "kms.admin",
    "k8s.admin"
  ]
}

module "terraform-viewer-sa" {
  source    = "./modules/service-account"
  name      = "terraform-viewer"
  folder_id = data.yandex_resourcemanager_folder.do-course-1-default.id
  cloud_id  = data.yandex_resourcemanager_cloud.do-course-1.id
  roles = [
    "compute.viewer",
    "resource-manager.viewer",
    "storage.viewer",
    "iam.viewer",
    "vpc.viewer",
    "load-balancer.viewer",
    "kms.viewer",
    "k8s.viewer"
  ]
}
