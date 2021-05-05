data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

data "template_file" "ses_user_template" {
  template = file("${path.module}/templates/iam/ses_user.tpl")
  vars     = {}
}

data "template_file" "ses_kms_policy" {
  template = file("${path.module}/templates/kms/kms_key_mgmt_policy.tpl")

  vars = {
    aws_account_id = data.aws_caller_identity.current.account_id
  }
}
