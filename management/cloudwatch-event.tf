resource "aws_cloudwatch_event_rule" "mgmt" {
  name                = "${var.environment_name}-mgmt-cwlogs-retention"
  description         = "Fires every one minutes"
  schedule_expression = "rate(7 days)"
}

resource "aws_cloudwatch_event_target" "mgmt" {
  rule      = aws_cloudwatch_event_rule.mgmt.name
  target_id = "lambda"
  arn       = aws_lambda_function.mgmt.arn
}
