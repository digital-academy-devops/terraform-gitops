output "terraform-static-key" {
  value     = module.terraform-sa.static-key
  sensitive = true
}

output "terraform-static-key-secret" {
  value     = module.terraform-sa.static-key-secret
  sensitive = true
}

output "terraform-key-json" {
  value     = module.terraform-sa.key-json
  sensitive = true
}

output "terraform-viewer-static-key" {
  value     = module.terraform-viewer-sa.static-key
  sensitive = true
}

output "terraform-viewer-static-key-secret" {
  value     = module.terraform-viewer-sa.static-key-secret
  sensitive = true
}

output "terraform-viewer-key-json" {
  value     = module.terraform-viewer-sa.key-json
  sensitive = true
}

output "cloud-id" {
  value = data.yandex_resourcemanager_cloud.do-course-1.id
}

output "default-subnets" {
  value = data.yandex_vpc_network.default.subnet_ids
}