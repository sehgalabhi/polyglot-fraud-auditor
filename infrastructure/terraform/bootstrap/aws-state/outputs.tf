output "aws_region" {
  description = "AWS region where backend resources were created."
  value       = var.aws_region
}

output "terraform_state_bucket_name" {
  description = "S3 bucket name for Terraform remote state."
  value       = aws_s3_bucket.state_bucket.bucket
}

output "terraform_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking."
  value       = aws_dynamodb_table.state_lock_table.name
}

