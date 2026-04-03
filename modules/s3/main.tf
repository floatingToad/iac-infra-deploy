###############################################################################
# S3 Module — S3 Bucket
###############################################################################

# ---------- S3 Bucket ----------
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name != "" ? var.bucket_name : "${var.project_name}-${var.bucket_suffix}"
  force_destroy = var.force_destroy

  tags = merge(var.common_tags, {
    Name = var.bucket_name != "" ? var.bucket_name : "${var.project_name}-${var.bucket_suffix}"
  })
}

# ---------- Versioning ----------
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

# ---------- Server-Side Encryption ----------
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? var.kms_key_id : null
    }
    bucket_key_enabled = var.sse_algorithm == "aws:kms" ? true : false
  }
}

# ---------- Block Public Access ----------
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}

# ---------- Bucket Policy (restrict access to specific IAM roles) ----------
resource "aws_s3_bucket_policy" "this" {
  count  = length(var.bucket_policy_principals) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPrincipalAccess"
        Effect    = "Allow"
        Principal = { AWS = var.bucket_policy_principals }
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.this]
}

# ---------- Lifecycle Rules (optional) ----------
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enable_lifecycle_rule ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "transition-and-expiration"
    status = "Enabled"

    transition {
      days          = var.lifecycle_glacier_transition_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.lifecycle_expiration_days
    }
  }
}
