output "s3_bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "ec2_public_ip" {
  value = data.aws_eip.existing_eip.public_ip
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.cdn.domain_name
  description = "Domain name of the CloudFront distribution"
}

output "acm_certificate_validation_options" {
  value       = aws_acm_certificate.frontend_cert.domain_validation_options
  description = "DNS records needed to validate the ACM certificate"
}
