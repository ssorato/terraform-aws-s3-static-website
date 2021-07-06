data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid       = "PublicReadGetObject"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::www.${var.domain_name}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "www.${var.domain_name}"
  acl = "public-read"
  policy = data.aws_iam_policy_document.s3_policy.json
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = merge(
    {
      "Name" = var.bucket_name
    },
    var.common_tag
  )
}

resource "aws_s3_bucket_public_access_block" "s3bucket_block_public" {
  bucket = aws_s3_bucket.s3bucket.id
  block_public_acls = false
  # block_public_policy = true
  # ignore_public_acls = true
  # restrict_public_buckets  = true
}

# Upload files to bucket
resource "aws_s3_bucket_object" "html" {

  for_each = fileset("website/", "*.html")
  bucket = aws_s3_bucket.s3bucket.id
  key = each.value
  source = "website/${each.value}"
  # etag: used to trigger updates
  etag = filemd5("website/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "jpg" {

  for_each = fileset("website/", "*.jpg")
  bucket = aws_s3_bucket.s3bucket.id
  key = each.value
  source = "website/${each.value}"
  # etag: used to trigger updates
  etag = filemd5("website/${each.value}")
  content_type = "image/jpeg"
}