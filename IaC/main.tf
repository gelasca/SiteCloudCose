module "s3-bucket" {
  source = "./Modules/s3-bucket"
  # manda para o módulo s3-bucket a variável bucket-name
  module-bucket-name = var.bucket-name
  module-website-path = var.website-path
}

# module "route53" {
#   source = "./Modules/route53"
#   module-domain-name = var.domain-name
#   domain_validation_options = module.certificate.domain-validation-options
#   certificate-arn = module.certificate.certificate-arn
# }

module "certificate" {
  source = "./Modules/certificate"
  module-domain-name = var.domain-name
  subject-alternative-names = [ "www.${var.domain-name}" ]
}

module "cloudfront" {
  source = "./Modules/cloudfront"
  module-domain-name = var.domain-name
  cdn-domain-name-and-origin-id = module.s3-bucket.bucket-regional-domain-name
  acm-certificate-arn = module.certificate.certificate-arn
  # depends_on = [ module.route53 ]
}

module "alias" {
  source = "./Modules/alias"
  module-domain-name = var.domain-name
  cloudfront-domain-name = module.cloudfront.cloudfront-domain-name
  cloudfront-zone-id = module.cloudfront.cloudfront-hosted-zone-id
  depends_on = [ module.cloudfront ]
}