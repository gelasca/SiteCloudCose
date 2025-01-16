#################################################
# usar quando quiser criar certificado pela acm #
#################################################

# resource "aws_acm_certificate" "ssl-certificate" {
#   domain_name = var.module-domain-name
#   validation_method = var.validation-method
#   subject_alternative_names = var.subject-alternative-names

#   lifecycle {
#     create_before_destroy = true
#   }
# }

#################################################

#######################################################
# usar quando quiser referenciar certificado pela acm #
#######################################################

data "aws_acm_certificate" "existing-certificate" {
  domain = var.module-domain-name
  # statuses = [ "AMAZON_ISSUED" ]
  statuses = [ "ISSUED" ]
}