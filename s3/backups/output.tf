# S3 Buckets
output "s3_backups" {
  value = {
    arn    = aws_s3_bucket.backups.arn
    domain = aws_s3_bucket.backups.bucket_domain_name
    name   = aws_s3_bucket.backups.id
    region = var.region
  }
}

