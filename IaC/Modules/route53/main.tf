data "aws_route53_zone" "hosted-zone" {
  name = var.module-domain-name
  private_zone = false
}

resource "aws_route53_record" "certificate-record" {
  # dvo é acrônimo para domain validation options
  for_each = { for dvo in var.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      type = dvo.resource_record_type
      record = dvo.resource_record_value
    } }

  name =each.value.name
  type = each.value.type
  records = [ each.value.record ]
  ttl = 60
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
}

resource "aws_acm_certificate_validation" "certificate-validation" {
  certificate_arn = var.certificate-arn
  validation_record_fqdns = [ for record in aws_route53_record.certificate-record : record.fqdn ]

  depends_on = [ aws_route53_record.certificate-record ]
}