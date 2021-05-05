resource "aws_iam_user" "ses_user" {
  name = "${local.project_name}-ses-pri-ses"
  path = "/"
}

resource "aws_iam_access_key" "ses_user_key" {
  user = aws_iam_user.ses_user.name
}

resource "aws_iam_user_policy" "ses_user_policy" {
  name   = "${local.project_name}-ses-pri-ses"
  user   = aws_iam_user.ses_user.name
  policy = data.template_file.ses_user_template.rendered
}