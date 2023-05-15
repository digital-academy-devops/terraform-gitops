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
}