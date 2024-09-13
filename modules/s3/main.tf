resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  #region = "ap-northeast-1"
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
