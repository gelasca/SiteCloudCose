# # o output permite usar esses valores no root
# output "certificate-arn" {
#   value = aws_acm_certificate.ssl-certificate.arn  
# }

# output "domain-validation-options" {
#   value = aws_acm_certificate.ssl-certificate.domain_validation_options
# }


# 

output "certificate-arn" {
  value = data.aws_acm_certificate.existing-certificate.arn
}