data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}
data "aws_iam_policy_document" "scheduler_role" {
  statement {
      actions = [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords"
      ]
      effect    = "Allow"
      resources = ["*"]
    }

  statement {
      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:Query",
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:ConditionCheckItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem"
      ]
      effect =  "Allow"
      resources = [
        aws_dynamodb_table.state_table.arn
      ]
  }

  statement {
      actions = [
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:BatchWriteItem"
      ]
      effect =  "Allow"
      resources = [
        aws_dynamodb_table.config_table.arn,
        aws_dynamodb_table.maintenance_window_table.arn
      ]
  }

  statement {
      actions = [
          "ssm:PutParameter",
          "ssm:GetParameter"
      ]
      effect =  "Allow"
      resources = [
          "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/Solutions/aws-instance-scheduler/UUID/*"
      ]
  }
}

resource "aws_iam_role" "scheduler_role" {
  name = "${var.common["environment_name"]}_AWS_Scheduler_Role"
  assume_role_policy = file("${path.module}/iam/trust.json")
  inline_policy {
    name = "SchedulerPolicy" 
    policy = data.aws_iam_policy_document.scheduler_role.json
  }
  tags = var.common["tags"]
}
