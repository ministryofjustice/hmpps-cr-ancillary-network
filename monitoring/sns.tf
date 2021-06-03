# CloudWatch Alarms
resource "aws_sns_topic" "alarm_notification" {
  name = "${var.environment_name}-alarm-notification"
}

resource "aws_sns_topic_subscription" "alarm_subscription" {
  protocol  = "lambda"
  topic_arn = aws_sns_topic.alarm_notification.arn
  endpoint  = aws_lambda_function.notify_slack_alarm.arn
}
