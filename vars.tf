variable "environment" {}

variable "service" {}

variable "cost_centre" {}

variable "owner" {}

variable "created_by" {}

variable "cdn_bucket_name" {}

variable "cdn_domain_name" {}

variable "cdn_ssl_cert_arn" {}

variable "cdn_default_ttl" {}

variable "wp_access_roles" {
    type = "list"
}
