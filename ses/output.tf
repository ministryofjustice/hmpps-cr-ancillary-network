output "smtp_credentials" {
  value = {
    username      = aws_iam_user.ses_user.name
    ssm_param     = aws_ssm_parameter.ses_user_smtppassword.name
    ssm_param_arn = aws_ssm_parameter.ses_user_smtppassword.arn
    smtp_endpoint = "email-smtp.${var.ses_region}.amazonaws.com"
    smtp_port     = var.ses_smtp_port
    kms_alias_arn = aws_kms_alias.ses_key_alias.arn
  }
}