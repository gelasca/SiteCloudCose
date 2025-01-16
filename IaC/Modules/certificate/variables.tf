variable "module-domain-name" {
  type = string
}

variable "validation-method" {
  type = string
  default = "DNS"
}

variable "subject-alternative-names" {
  type = list(string)
  default = [ ]
}