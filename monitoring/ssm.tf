resource "random_password" "slack_token" {
  length  = 30
  special = false
}

resource "aws_ssm_parameter" "slack_token" {
  name        = "/${var.environment_name}/slack/token"
  description = "Slack API Token"
  type        = "SecureString"
  value       = random_password.slack_token.result

  tags = merge(
    local.tags,
    {
      "Name" = "/${var.environment_name}/slack/token"
    },
  )

  lifecycle {
    ignore_changes = [value]
  }
}
