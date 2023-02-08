variable "instance_number" {
  type    = number
  default = 3
}

variable "zone" {
  type    = string
}

variable "group_prefix" {
  type    = string
  default = "test"
}

variable "group_name" {
  type    = string
  default = "appservers"
}

variable "image_name" {
  type  = string
  default = "ubuntu-2204-lts"
}