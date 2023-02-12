variable "environment" {
  type    = string
  default = ""
}

variable "repository" {
  type    = string
  default = ""
}

variable "reviewers" {
  type    = list(number)
  default = []
}

variable "protected_branches" {
  type    = bool
  default = true
}

variable "secrets" {
  type    = map(any)
  default = {}

}