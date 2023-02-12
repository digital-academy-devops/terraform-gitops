output "static-key" {
  value     = yandex_iam_service_account_static_access_key.static-key.access_key
  sensitive = true
}

output "static-key-secret" {
  value     = yandex_iam_service_account_static_access_key.static-key.secret_key
  sensitive = true
}

locals {
  key-json = {
    id                 = yandex_iam_service_account_key.key.id
    service_account_id = yandex_iam_service_account_key.key.service_account_id
    created_at         = yandex_iam_service_account_key.key.created_at
    key_algorithm      = yandex_iam_service_account_key.key.key_algorithm
    public_key         = yandex_iam_service_account_key.key.public_key
    private_key        = yandex_iam_service_account_key.key.private_key
  }

}

output "key-json" {
  sensitive = true
  value     = jsonencode(local.key-json)
}
