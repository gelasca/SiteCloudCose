data "aws_route53_zone" "hosted-zone" {
  name = var.module-domain-name
}

resource "aws_route53_record" "alias1" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name = var.module-domain-name
  type = "A"

  alias {
    name = var.cloudfront-domain-name
    zone_id = var.cloudfront-zone-id
    evaluate_target_health = false
  }
}

# adicionado depois

resource "aws_route53_record" "alias2" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name = "www.${var.module-domain-name}"
  type = "A"
  

  alias {
    name = var.cloudfront-domain-name
    zone_id = var.cloudfront-zone-id
    evaluate_target_health = false
  }
}