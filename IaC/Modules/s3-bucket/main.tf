resource "aws_s3_bucket" "cloudcose-site" {
  bucket = var.module-bucket-name
  force_destroy = true
}

resource "aws_s3_object" "updated-objects" {
  # espera um map ou um set de dados
  for_each = fileset("${var.module-website-path}","**/*")
  bucket = aws_s3_bucket.cloudcose-site.bucket
  # é usado each.value, pois o each.key contém só o índice 
  key = each.value
  source = "${var.module-website-path}/${each.value}"
  content_type = lookup(var.mime-types,regex("\\.[^.]+$",each.value),"application/octet-stream")
}

# jeito antigo de se adicionar policy
resource "aws_s3_bucket_policy" "name" {
  bucket = aws_s3_bucket.cloudcose-site.bucket
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AllowCloudFrontServicePrincipal",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.cloudcose-site.arn}/*",
        Condition = {
          StringLike = {
            "aws:UserAgent" = "Amazon CloudFront"
          }
        }
      }
    ]
  })
}


###########################################
# Adiciona política e acl parao bucket s3 #
###########################################

# resource "aws_s3_bucket_public_access_block" "bucket-access-block" {
#   bucket = aws_s3_bucket.cloudcose-institutional-site.id

#   block_public_acls       = true
#   block_public_policy     = false
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_policy" "bucket-permission" {
#   bucket = aws_s3_bucket.cloudcose-institutional-site.id
#   policy = data.aws_iam_policy_document.bucket-permission-json.json
# }

# data "aws_iam_policy_document" "bucket-permission-json" {
#   statement {
#     principals {
#       type = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.cloudcose-institutional-site.arn,
#       "${aws_s3_bucket.cloudcose-institutional-site.arn}/*",
#     ]
#   }
# }