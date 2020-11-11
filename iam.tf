resource "aws_s3_bucket_policy" "cdn" {
  bucket = aws_s3_bucket.cdn.id
  policy = data.aws_iam_policy_document.s3_bucket_cdn.json
}

data "aws_iam_policy_document" "s3_bucket_cdn" {

  statement {
    sid    = "AllowCloudFrontObjectRead"
    effect = "Allow"

    actions   = [
        "s3:GetObject"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cdn.iam_arn]
    }

    resources = [
      "${aws_s3_bucket.cdn.arn}/*"
    ]
  }

  statement {
    sid = "wp_permissions"
    effect = "Allow"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]

    principals {
      identifiers = var.wp_access_roles
      type = "AWS"
    }

    resources = [
      aws_s3_bucket.cdn.arn
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]

    principals {
      identifiers = var.wp_access_roles
      type = "AWS"
    }

    resources = [
      "${aws_s3_bucket.cdn.arn}/*"
    ]
  }
}