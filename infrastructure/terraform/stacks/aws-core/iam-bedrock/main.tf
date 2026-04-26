resource "aws_iam_role" "app" {
  name               = local.role_name
  assume_role_policy = local.assume_role_policy
}

data "aws_iam_policy_document" "app_permissions" {
  statement {
    sid    = "SqsAlerts"
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
    ]
    resources = [
      var.alerts_queue_arn,
      var.alerts_dlq_arn,
    ]
  }

  statement {
    sid    = "DynamoAuditTable"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:DescribeTable",
    ]
    resources = [
      var.dynamodb_table_arn,
      "${var.dynamodb_table_arn}/index/*",
    ]
  }

  statement {
    sid    = "BedrockInvoke"
    effect = "Allow"
    actions = [
      "bedrock:InvokeModel",
      "bedrock:InvokeModelWithResponseStream",
    ]
    resources = [local.bedrock_resource]
  }
}

resource "aws_iam_role_policy" "app_inline" {
  name   = "${local.role_name}-inline"
  role   = aws_iam_role.app.id
  policy = data.aws_iam_policy_document.app_permissions.json
}
