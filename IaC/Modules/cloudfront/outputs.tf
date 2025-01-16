output "cloudfront-arn" {
  value = aws_cloudfront_distribution.cloudcose-cdn
}

output "cloudfront-domain-name" {
  value = aws_cloudfront_distribution.cloudcose-cdn.domain_name
}

output "cloudfront-hosted-zone-id" {
  value = aws_cloudfront_distribution.cloudcose-cdn.hosted_zone_id
}