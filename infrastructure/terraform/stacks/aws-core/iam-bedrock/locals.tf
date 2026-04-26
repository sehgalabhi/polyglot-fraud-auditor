locals {
  role_name = "${var.environment}-${var.app_role_name}"

  default_assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  assume_role_policy = coalesce(var.assume_role_policy_json, local.default_assume_role_policy)

  bedrock_resource = coalesce(
    var.bedrock_model_arn,
    "arn:aws:bedrock:${var.aws_region}::foundation-model/*"
  )
}
