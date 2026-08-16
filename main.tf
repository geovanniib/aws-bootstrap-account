


resource "random_id" "bucket_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "bootstrap" {
    bucket = "${var.prefix_base}-state-${random_id.bucket_id.hex}"
    tags = var.tags
}


resource "aws_s3_bucket_versioning" "bootstrap" {
  bucket = aws_s3_bucket.bootstrap.id
  versioning_configuration {
    status = "Enabled"
  }
}

