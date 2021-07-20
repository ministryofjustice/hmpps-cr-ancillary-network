variable "default_log_retention_days" {
  description = "default cloudwatch log retention days"
  default     = 30
}

variable "environment_name" {
  description = "Environment name to be used as a unique identifier for resources - eg. cr-jitbit-dev"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
