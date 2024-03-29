resource "aws_lambda_function" "notify_slack_alarm" {
  runtime          = "nodejs16.x"
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.alarm_lambda_handler_zip.output_path
  function_name    = local.lambda_name_alarm
  handler          = "notify-slack-alarm.handler"
  source_code_hash = filebase64sha256(data.archive_file.alarm_lambda_handler_zip.output_path)
  environment {
    variables = {
      ENABLED                 = var.environment_name == "cr-jitbit-training" ? "false" : (local.alarms_config.enabled)
      REGION                  = var.region
      ENVIRONMENT_NAME        = var.environment_name
      QUIET_PERIOD_START_HOUR = tostring(local.alarms_config.quiet_hours[0])
      QUIET_PERIOD_END_HOUR   = tostring(local.alarms_config.quiet_hours[1])
      SLACK_CHANNEL           = var.channel
      SLACK_TOKEN             = "/${var.environment_name}/slack/token"
    }
  }
}

resource "aws_cloudwatch_log_group" "notify_slack_alarm" {
  name              = "/aws/lambda/${local.lambda_name_alarm}"
  retention_in_days = 14
}

resource "aws_lambda_permission" "sns_alarm" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notify_slack_alarm.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.alarm_notification.arn
}
