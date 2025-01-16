variable "module-domain-name" {
  type = string
}

variable "domain_validation_options" {
  type = list(object({
    domain_name = string
    resource_record_name = string
    resource_record_type = string
    resource_record_value = string

  }))
}

variable "certificate-arn" {
  type = string
}