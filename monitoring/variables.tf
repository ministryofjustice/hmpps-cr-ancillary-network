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

variable "alarms_config" {
  type = object({
    enabled     = bool
    quiet_hours = tuple([number, number])
  })
  default = {
    enabled     = true
    quiet_hours = [23, 6]
  }
}

variable "channel" {
  description = "Slack channel to send notification"
  default     = "cr-auto-stop-alerts" //Channel dosnt exists just default value
}
