locals {
  lambda_name_alarm  = "${var.environment_name}-notify-slack-channel-alarm"
  slack_compose      = replace(var.environment_type, "dev", "nonprod")
  slack_channel_name = "${var.project_name}-alerts-${local.slack_compose}"
  tags               = var.tags

  alarms_config   = {
      enable      = false
      quiet_hours = [19, 7]
    }
}
