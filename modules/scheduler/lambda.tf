resource "aws_lambda_function" "aws_scheduler_function" {
  function_name = "${var.common["environment_name"]}_aws_scheduler"
  description   = "schedule EC2 and RDS instances"
  s3_bucket     = "solutions-${data.aws_region.current.name}"
  s3_key        = "aws-instance-scheduler/v1.4.0/instance-scheduler.zip"
  dead_letter_config {
    target_arn = var.deadletter
  }
  handler = "main.lambda_handler"
  runtime = "python3.8"
  timeout = 900
  role    = aws_iam_role.scheduler_role.arn
  environment {
    variables = {
      ACCOUNT = data.aws_caller_identity.current.account_id
      BOTO_RETRY = "5,10,30,0.25"
      CONFIG_TABLE = aws_dynamodb_table.config_table.name
      DDB_TABLE_NAME = aws_dynamodb_table.state_table.name
      ENABLE_SSM_MAINTENANCE_WINDOWS = "false"
      ENV_BOTO_RETRY_LOGGING = "FALSE"
      ISSUES_TOPIC_ARN = aws_sns_topic.aws_scheduler.arn
      LOG_GROUP = aws_cloudwatch_log_group.aws_instance_scheduler.name
      MAINTENANCE_WINDOW_TABLE = aws_dynamodb_table.maintenance_window_table.name
      METRICS_URL = "https://metrics.awssolutionsbuilder.com/generic"
      REGIONS = "eu-west-2"
      SCHEDULER_FREQUENCY = "5"
      SEND_METRICS = "False"
      SOLUTION_ID = "S00030"
      START_EC2_BATCH_SIZE = 5
      STATE_TABLE = aws_dynamodb_table.state_table.name
      TAG_NAME = "Schedule"
      TRACE = "FALSE"
      USER_AGENT = "InstanceScheduler-aws-scheduler-140-v1.4.0"
      USER_AGENT_EXTRA = "AwsSolution/SO0030/v1.4.0"
      UUID_KEY = "/Solutions/aws-instance-scheduler/UUID/"
    }
  }
  tags = var.common["tags"]
}
