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

/*
resource "aws_dynamodb_table_item" "config-schedule" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/scheduler.json")
}

resource "aws_dynamodb_table_item" "period-weekdays" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/period-weekdays.json")
}

resource "aws_dynamodb_table_item" "period-weekend" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/period-weekend.json")
}

resource "aws_dynamodb_table_item" "period-stoponly" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/period-alwaysstop.json")
}

resource "aws_dynamodb_table_item" "schedule-sydney" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/schedule-sydney.json")
}

resource "aws_dynamodb_table_item" "schedule-brisbane" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/schedule-brisbane.json")
}

resource "aws_dynamodb_table_item" "schedule-sydney-so" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/schedule-sydney-stop.json")
}

resource "aws_dynamodb_table_item" "schedule-brisbane-so" {
  table_name = aws_dynamodb_table.config-table.name
  hash_key   = aws_dynamodb_table.config-table.hash_key
  range_key  = aws_dynamodb_table.config-table.range_key
  item = file("./dynamodb-json/schedule-brisbane-stop.json")
}
*/