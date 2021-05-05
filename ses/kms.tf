resource "aws_kms_key" "ses_key" {
  description             = "Engineering SES Encryption Key"
  deletion_window_in_days = 30
  policy                  = data.template_file.ses_kms_policy.rendered
  tags = merge(
    local.tags,
    {
      "Name" = "${local.project_name}-ses-pri-kms"
    },
  )
}

resource "aws_kms_alias" "ses_key_alias" {
  name          = "alias/ses-kms-key"
  target_key_id = aws_kms_key.ses_key.key_id
}