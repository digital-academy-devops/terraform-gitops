terraform {

  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "dac-testcloud-tf"
    region   = "ru-central1"
    key      = "example/terraform.tfstate"
    profile  = "yc"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  zone = local.zone
}