provider "aws" {
  region = var.aws_region

  dynamic "endpoints" {
    for_each = var.aws_endpoint_override == null ? [] : [var.aws_endpoint_override]
    content {
      dynamodb = endpoints.value
    }
  }

  default_tags {
    tags = merge(
      {
        Project     = var.project_name
        Environment = var.environment
        ManagedBy   = "terraform"
        Stack       = "aws-core-dynamodb"
      },
      var.tags
    )
  }
}
