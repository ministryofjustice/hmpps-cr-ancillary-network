locals {
  lambda_name_alarm  = "${var.environment_name}-notify-slack-channel-alarm"
  tags               = var.tags
  alarms_config      = var.alarms_config
}
