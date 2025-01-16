# variáveis para criar oac
variable "oac-name" {
  type = string
  default = "cloudcose-site-oac"
}

variable "origin-access-cors" {
  type = string
  default = "s3"
}

variable "signing-behavior" {
  type = string
  default = "always"  
}

variable "signing-protocol" {
  type = string
  default = "sigv4"
}

# variáveis para criar cloudfront
variable "restriction-type" {
  type = string
  default = "none"
}

variable "default-root-object" {
  type = string
  default = "index.html"
}

variable "module-domain-name" {
  type = string
}

variable "cdn-domain-name-and-origin-id" {
  type = string
}

variable "acm-certificate-arn" {
  type = string
}