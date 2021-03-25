# ### oracledb-backups-s3bucket
# S3 Bucket name will have
# "region-environment_name" prepended

locals {
  bucket_name = "${var.tiny_environment_identifier}-backups"
}

resource "aws_s3_bucket" "backups" {
  bucket = local.bucket_name
  acl    = "private"

  versioning {
    enabled = false
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    var.tags,
    { "Name" = local.bucket_name },
  )
}

resource "aws_s3_bucket_public_access_block" "documents" {
  bucket              = aws_s3_bucket.backups.id
  block_public_acls   = true
  block_public_policy = true
}
