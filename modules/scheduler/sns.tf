resource "aws_sns_topic" "aws_scheduler" {
  name = "${var.common["environment_name"]}_AWS_Scheduler"
}
