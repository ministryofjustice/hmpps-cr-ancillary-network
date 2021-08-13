resource "aws_cloudwatch_log_group" "aws_instance_scheduler" {
  name = "/aws/${var.common["environment_name"]}/AWS_Instance_Scheduler"
  retention_in_days = 14
  tags = var.common["tags"]
}

resource "aws_cloudwatch_event_rule" "aws_scheduler_event_rule" {
  name        = "${var.common["environment_name"]}-aws-scheduler-event-rule"
  description = "	Instance Scheduler - Rule to trigger instance for scheduler function version v1.4.0"
  schedule_expression = "rate(5 minutes)"
  is_enabled = true
}

resource "aws_cloudwatch_event_target" "aws_scheduler_function" {
  rule      = aws_cloudwatch_event_rule.aws_scheduler_event_rule.name
  target_id = "Function"
  arn       = aws_lambda_function.aws_scheduler_function.arn
}

resource "aws_lambda_permission" "aws_schedule_allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws_scheduler_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_target.aws_scheduler_function.arn
}
