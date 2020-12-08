output "cdn_bucket_name" {
    value = aws_s3_bucket.cdn.bucket
}

output "cdn_s3_bucket_arn" {
    value = aws_s3_bucket.cdn.arn
}

output "cdn_cloudfront_domain_name" {
    value = aws_cloudfront_distribution.cdn.domain_name
}

output "cdn_cloudfront_origin_access_identity_iam_arn" {
    value = aws_cloudfront_origin_access_identity.cdn.iam_arn
}
