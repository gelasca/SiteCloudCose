# cria OAC de acordo com os valores default passados em variables.tf
resource "aws_cloudfront_origin_access_control" "assign-oac" {
  name = var.oac-name
  origin_access_control_origin_type = var.origin-access-cors
  signing_behavior = var.signing-behavior
  signing_protocol = var.signing-protocol
}

resource "aws_cloudfront_distribution" "cloudcose-cdn" {
  origin {
    domain_name = var.cdn-domain-name-and-origin-id
    origin_id = var.cdn-domain-name-and-origin-id
    origin_access_control_id = aws_cloudfront_origin_access_control.assign-oac.id
  }

  default_cache_behavior {
    compress = true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [ "GET", "HEAD" ]
    cached_methods = [ "GET", "HEAD" ]
    target_origin_id = var.cdn-domain-name-and-origin-id
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400

    forwarded_values {
      query_string = false
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction-type
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm-certificate-arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
    cloudfront_default_certificate = false
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = var.default-root-object
  aliases = [ var.module-domain-name, "www.${var.module-domain-name}" ]
}