data "aws_caller_identity" "current" {
}

data "archive_file" "alarm_lambda_handler_zip" {
  type        = "zip"
  output_path = "${path.module}/files/${local.lambda_name_alarm}.zip"
  source {
    content  = file("${path.module}/lambda/notify-slack-alarm.js")
    filename = "notify-slack-alarm.js"
  }
}
