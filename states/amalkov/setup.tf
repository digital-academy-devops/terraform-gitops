terraform {

  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.85.0"
    }
  }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "do-course-1-tf"
    region   = "ru-central1"
    key      = "states/folders/amalkov/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

data "terraform_remote_state" "system" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    endpoint = "storage.yandexcloud.net"
    bucket   = "do-course-1-tf"
    region   = "ru-central1"
    key      = "states/system/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  service_account_key_file = "sa_key.json"
  cloud_id                 = data.terraform_remote_state.system.outputs.cloud-id
  folder_id                = data.terraform_remote_state.system.outputs.amalkov-folder-id
}
