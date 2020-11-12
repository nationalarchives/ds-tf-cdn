resource "aws_s3_bucket" "cdn" {
    bucket = var.cdn_bucket_name
    acl    = "public-read"

    website {
        index_document = "index.html"
        error_document = "404.html"
    }

    tags = {
        Name        = var.cdn_bucket_name
        Environment = var.environment
        Service     = var.service
        Owner       = var.owner
        CreatedBy   = var.created_by
        CostCentre  = var.cost_centre
        Terraform   = "true"
    }
}
