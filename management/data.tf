data "aws_caller_identity" "current" {
}

data "archive_file" "lambda_handler_zip" {
  type        = "zip"
  output_path = "${path.module}/files/${var.environment_name}-mgmt-cwlogs-retention.zip"
  source {
    content  = file("${path.module}/lambda/lambda_function.py")
    filename = "lambda_function.py"
  }
}