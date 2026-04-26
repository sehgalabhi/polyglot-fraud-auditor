output "app_role_name" {
  description = "IAM role name for the app workload."
  value       = aws_iam_role.app.name
}

output "app_role_arn" {
  description = "IAM role ARN to assume or attach instance profile."
  value       = aws_iam_role.app.arn
}

output "app_role_id" {
  description = "IAM role ID."
  value       = aws_iam_role.app.id
}
