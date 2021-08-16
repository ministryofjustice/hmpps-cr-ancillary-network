variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}

variable "region" {
  description = "The AWS region."
}

variable "environment_name" {
  description = "Environment name to be used as a unique identifier for resources - eg. cr-jitbit-dev"
}

variable "environment_type" {
  description = "Environment type to be used as a unique identifier for resources - eg. jitbit-dev"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

variable "project_name" {
  description = "Project name to be used as a unique identifier for resources - eg. cr"
}

variable "schedule_start_action" {
  description = "Define the schedule option - ie start or stop"
  default     = "start"
}

variable "schedule_stop_action" {
  description = "Define the schedule option - ie start or stop"
  default     = "stop"
}

variable "ec2_schedule" {
  description = "Enable or disable the auto start and power off of instances"
  default     = "false"
}

variable "spot_schedule" {
  description = "Enable or disable auto start/stop of spot instances"
  default     = "false"
}

variable "rds_schedule" {
  description = "Enable or disable auto start/stop of RDS Instances"
  default     = "false"
}

variable "autoscaling_schedule" {
  description = "Enable or disable auto start/stop of ASG"
  default     = "true"
}

variable "stop_resources_tag_phase1" {
  description = "Autostop tag value used by lambda to stop instances"
  default     = "Phase1"
}

variable "stop_resources_tag_phase2" {
  description = "Autostop tag value used by lambda to stop instances"
  default     = "True"
}

variable "start_resources_tag_phase1" {
  description = "Autostop tag value used by lambda to start instances"
  default     = "Phase1"
}

variable "start_resources_tag_phase2" {
  description = "Autostop tag value used by lambda to start instances"
  default     = "True"
}

variable "calendar_rule_enabled" {
  description = "Whether the Calendar rule should be enabled"
  type        = string
  default     = "false"
}

variable "rate_schedule_expression" {
  description = "Rate to check calendar events"
  default     = "cron(0/20 * * * ? *)"
}

variable "calender_content_doc" {
  description = "File for calendar ssm document"
  default     = "file://files/calendar_content"
}

variable "create_autostop_instance" {
  default = "false"
}