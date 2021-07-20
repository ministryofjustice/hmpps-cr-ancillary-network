resource "aws_iam_role" "lambda_role" {
  name               = "${var.environment_name}-mgmt-cwlogs-retention-role"
  description        = "Role enabling Lambda to access related to cw"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
  tags               = merge(var.tags, { Name = "${var.environment_name}-mgmt-cwlogs-retention-role" })
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    sid       = "Logging"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
  statement {
    sid       = "Loadbalancer"
    effect    = "Allow"
    resources = ["*"]
    actions   = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:ModifyListener"
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.environment_name}-mgmt-cwlogs-retention-role"
  policy = data.aws_iam_policy_document.lambda_policy_document.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
