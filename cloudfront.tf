resource "aws_cloudfront_distribution" "cdn" {

    origin {
        domain_name = aws_s3_bucket.cdn.bucket_regional_domain_name
        origin_id   = var.cdn_domain_name

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.cdn.cloudfront_access_identity_path
        }
    }

    aliases = [
        var.cdn_domain_name
    ]

    enabled             = true
    default_root_object = "index.html"

    default_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        compress               = true
        allowed_methods        = [
            "GET",
            "HEAD"]
        cached_methods         = [
            "GET",
            "HEAD"]
        target_origin_id       = var.cdn_domain_name
        min_ttl                = 0
        default_ttl            = var.cdn_default_ttl
        max_ttl                = 31536000

        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }
    }

    // PriceClass_100: Limit to only Europe, USA, and Canada endpoints
    price_class = "PriceClass_100"

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = var.cdn_ssl_cert_arn
        ssl_support_method  = "sni-only"
    }

    tags = {
        Name        = "${var.cdn_bucket_name}-cloudfront"
        Environment = var.environment
        Service     = var.service
        Owner       = var.owner
        CreatedBy   = var.created_by
        CostCentre  = var.cost_centre
        Terraform   = "true"
    }
}

resource "aws_cloudfront_origin_access_identity" "cdn" {
    comment = "CloudFront OAI for ${var.environment} ${var.cdn_domain_name}"
}
