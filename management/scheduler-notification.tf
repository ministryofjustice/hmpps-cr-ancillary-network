# Notify in slack that instance will go down in 60mins
module "autostop-notify" {
  source                         = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/auto-start/auto-stop-notify?ref=terraform-0.12"
  name                           = var.environment_name
  cloudwatch_schedule_expression = var.stop_cloudwatch_notification_schedule_expression
  event_rule_enabled             = var.autostop_notification_enable
  channel                        = var.channel
  url_path                       = var.url_path
  tagged_user                    = var.tagged_user
}

# Notification Lambda details
data "aws_lambda_function" "auto-startstop-scheduler-notification" {
  function_name = "${var.environment_name}-auto-stop-notification"
}

# Cloudwatch Stop event
resource "aws_cloudwatch_event_rule" "auto-stop-scheduler-notification" {
  name                = "${var.environment_name}-auto-stop-scheduler-notification-event-rule"
  description         = "Daily Auto Stop Notification"
  schedule_expression = var.stop_cloudwatch_notification_schedule_expression
  is_enabled          = var.autostartstop_notification_enable
}

resource "aws_cloudwatch_event_target" "auto-stop-scheduler-notification" {
  arn  = data.aws_lambda_function.auto-startstop-scheduler-notification.arn
  rule = aws_cloudwatch_event_rule.auto-stop-scheduler-notification.name
  input = "{\"action\": \"stop\"}"
}

resource "aws_lambda_permission" "auto-stop-scheduler-notification" {
  statement_id  = "AllowExecutionFromCloudWatchforStop"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = data.aws_lambda_function.auto-startstop-scheduler-notification.function_name
  source_arn    = aws_cloudwatch_event_rule.auto-stop-scheduler-notification.arn
}

# Cloudwatch Start event
resource "aws_cloudwatch_event_rule" "auto-start-scheduler-notification" {
  name                = "${var.environment_name}-auto-start-scheduler-notification-event-rule"
  description         = "Daily Auto Start Notification"
  schedule_expression = var.start_cloudwatch_notification_schedule_expression
  is_enabled          = var.autostartstop_notification_enable
}

resource "aws_cloudwatch_event_target" "auto-start-scheduler-notification" {
  arn  = data.aws_lambda_function.auto-startstop-scheduler-notification.arn
  rule = aws_cloudwatch_event_rule.auto-start-scheduler-notification.name
  input = "{\"action\": \"start\"}"
}

resource "aws_lambda_permission" "auto-start-scheduler-notification" {
  statement_id  = "AllowExecutionFromCloudWatchforStart"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = data.aws_lambda_function.auto-startstop-scheduler-notification.function_name
  source_arn    = aws_cloudwatch_event_rule.auto-start-scheduler-notification.arn
}
