resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = var.name
}

resource "yandex_resourcemanager_cloud_iam_binding" "cloud-bindings" {
  for_each = toset(var.roles)
  cloud_id = var.cloud_id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
  role = each.key
}


resource "yandex_iam_service_account_static_access_key" "static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "used for state access"
}

resource "yandex_iam_service_account_key" "key" {
  service_account_id = yandex_iam_service_account.sa.id
}