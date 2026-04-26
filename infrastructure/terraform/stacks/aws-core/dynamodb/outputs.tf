output "dynamodb_table_name" {
  description = "DynamoDB table name."
  value       = aws_dynamodb_table.audit_context.name
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN."
  value       = aws_dynamodb_table.audit_context.arn
}

output "dynamodb_partition_key" {
  description = "Partition key attribute name."
  value       = var.partition_key_name
}
