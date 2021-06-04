locals {
  lambda_name_alarm  = "${var.environment_name}-notify-slack-channel-alarm"
  slack_compose      = replace(var.environment_type, "dev", "nonprod")
  slack_channel_name = "${var.project_name}-alert-${local.slack_compose}"
  tags               = var.tags
  alarms_config      = var.alarms_config
}
