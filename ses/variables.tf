variable "region" {
}

variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}

variable "environment_type" {
  description = "environment"
}

variable "environment_name" {
  type = string
}

variable "project_name" {
  description = "project name"
}

variable "ses_smtp_port" {
  description = "SMTP Endpoint Point"
  default     = 465
}

variable "tags" {
  type = map(string)
}
