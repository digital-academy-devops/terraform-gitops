terraform {

  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.85.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "do-course-1-tf"
    region   = "ru-central1"
    key      = "states/system/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  zone = "ru-central1-a"
  service_account_key_file = "sa_key.json"
}

provider "github" {}

provider "random" {}

# cloud and default folder created via UI
data "yandex_resourcemanager_cloud" "do-course-1" {
  name = "do-course-1"
}

data "yandex_resourcemanager_folder" "do-course-1-default" {
  name     = "default"
  cloud_id = data.yandex_resourcemanager_cloud.do-course-1.id
}