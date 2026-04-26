resource "aws_dynamodb_table" "audit_context" {
  name         = "${var.environment}-${var.table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.partition_key_name

  attribute {
    name = var.partition_key_name
    type = "S"
  }
}
