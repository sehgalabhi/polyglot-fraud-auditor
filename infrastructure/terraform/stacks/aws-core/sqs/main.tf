resource "aws_sqs_queue" "alerts_dlq" {
  name = "${var.environment}-${var.alerts_dlq_name}"
}

resource "aws_sqs_queue" "alerts" {
  name = "${var.environment}-${var.alerts_queue_name}"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.alerts_dlq.arn
    maxReceiveCount     = var.alerts_max_receive_count
  })
}
