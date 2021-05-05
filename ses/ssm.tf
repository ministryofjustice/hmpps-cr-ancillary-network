resource "aws_ssm_parameter" "ses_user_smtppassword" {
  name        = "/${var.environment_name}/${var.project_name}/ses/ses_user_smtppassword"
  description = "SES User SMTP Password"
  type        = "SecureString"
  value       = aws_iam_access_key.ses_user_key.ses_smtp_password_v4

  tags = merge(
    local.tags,
    {
      "Name" = "/${var.environment_name}/${var.project_name}/ses/ses_user_smtppassword"
    },
  )
}
