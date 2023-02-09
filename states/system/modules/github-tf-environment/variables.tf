variable "environment" {
  type = string
  default = ""
}

variable "repository" {
  type = string
  default = ""
}

variable "reviewers" {
  type = list(number)
  default = []
}

variable "secrets" {
  type = map(any)
  default = {}

}