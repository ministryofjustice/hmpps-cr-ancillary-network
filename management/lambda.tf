resource "aws_lambda_function" "mgmt" {
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.lambda_handler_zip.output_path
  function_name    = "${var.environment_name}-mgmt-cwlogs-retention"
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.lambda_handler_zip.output_path)
  environment {
    variables = {
      default_log_retention_days = var.default_log_retention_days
    }
  }
}

resource "aws_cloudwatch_log_group" "mgmt" {
  name              = "/aws/lambda/${var.environment_name}-mgmt-cwlogs-retention"
  retention_in_days = 14
}

resource "aws_lambda_permission" "mgmt" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.mgmt.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.mgmt.arn
}