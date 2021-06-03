locals {
  lambda_name_alarm = "${var.environment_name}-notify-slack-channel-alarm"
  slack_compose      = var.environment_type
  # slack_channel_name = "${var.project_name}-alerts-"
  tags = var.tags
}
