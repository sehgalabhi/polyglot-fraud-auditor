output "alerts_queue_name" {
  description = "Main SQS alerts queue name."
  value       = aws_sqs_queue.alerts.name
}

output "alerts_queue_url" {
  description = "Main SQS alerts queue URL."
  value       = aws_sqs_queue.alerts.url
}

output "alerts_queue_arn" {
  description = "Main SQS alerts queue ARN."
  value       = aws_sqs_queue.alerts.arn
}

output "alerts_dlq_name" {
  description = "SQS dead-letter queue name."
  value       = aws_sqs_queue.alerts_dlq.name
}

output "alerts_dlq_url" {
  description = "SQS dead-letter queue URL."
  value       = aws_sqs_queue.alerts_dlq.url
}

output "alerts_dlq_arn" {
  description = "SQS dead-letter queue ARN."
  value       = aws_sqs_queue.alerts_dlq.arn
}
