variable "name" {
  type = string
  default = ""
}

variable "folder_id" {
  type = string
  default = ""
}

variable "cloud_id" {
  type = string
  default = ""
}

variable "roles" {
  type = list(string)
  default = []
}