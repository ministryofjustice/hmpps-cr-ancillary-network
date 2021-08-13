resource "aws_dynamodb_table" "state_table" {
  name           = "${var.common["environment_name"]}_AWS_Scheduler_StateTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "service"
  range_key      = "account-region"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "service"
    type = "S"
  }

  attribute {
    name = "account-region"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = var.common["tags"]
}

resource "aws_dynamodb_table" "config_table" {
  name           = "${var.common["environment_name"]}_AWS_Scheduler_ConfigTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "type"
  range_key      = "name"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "type"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = var.common["tags"]
}

resource "aws_dynamodb_table" "maintenance_window_table" {
  name           = "${var.common["environment_name"]}_AWS_Scheduler_MaintenanceWindowTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "name"
  range_key      = "account-region"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "account-region"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = var.common["tags"]
}

# EU London Time Zone - https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
resource "aws_dynamodb_table_item" "global_config" {
  table_name = aws_dynamodb_table.config_table.name
  hash_key   = aws_dynamodb_table.config_table.hash_key
  range_key  = aws_dynamodb_table.config_table.range_key
  item = file("${path.module}/config/global_config.json")
}

# Scheduler time 7:00 - 18:00
resource "aws_dynamodb_table_item" "period" {
  table_name = aws_dynamodb_table.config_table.name
  hash_key   = aws_dynamodb_table.config_table.hash_key
  range_key  = aws_dynamodb_table.config_table.range_key
  item = file("${path.module}/config/period.json")
}

# Tag "Key=Schedule,Value=office-hours"
resource "aws_dynamodb_table_item" "schedule" {
  table_name = aws_dynamodb_table.config_table.name
  hash_key   = aws_dynamodb_table.config_table.hash_key
  range_key  = aws_dynamodb_table.config_table.range_key
  item = file("${path.module}/config/scheduler.json")
}
