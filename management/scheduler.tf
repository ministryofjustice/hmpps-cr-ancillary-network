# SSM Calendar to schedule instance availability
module "calendar" {
  source               = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/auto-start/calendar?ref=terraform-0.12"
  environment_name     = local.environment_name
  tags                 = var.tags
  region               = var.region
  is_enabled           = var.calendar_rule_enabled
  schedule_expression  = var.rate_schedule_expression
  calender_content_doc = var.calender_content_doc
}

# Start instances in a staggered order
module "ec2-start-phase1" {
  source               = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/auto-start/lambda-scheduler-stop-start?ref=terraform-0.12"
  name                 = "${local.environment_name}-start-ec2-phase1"
  schedule_action      = var.schedule_start_action
  spot_schedule        = var.spot_schedule
  ec2_schedule         = var.ec2_schedule
  rds_schedule         = var.rds_schedule
  autoscaling_schedule = var.autoscaling_schedule
  environment_name     = local.environment_name

  resources_tag = {
    key   = "autostop"
    value = var.start_resources_tag_phase1
  }
}

module "ec2-start-phase2" {
  source               = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/auto-start/lambda-scheduler-stop-start?ref=terraform-0.12"
  name                 = "${local.environment_name}-start-ec2-phase2"
  schedule_action      = var.schedule_start_action
  spot_schedule        = var.spot_schedule
  ec2_schedule         = var.ec2_schedule
  rds_schedule         = var.rds_schedule
  autoscaling_schedule = var.autoscaling_schedule
  environment_name     = local.environment_name

  resources_tag = {
    key   = "autostop"
    value = var.start_resources_tag_phase2
  }
}

# Stop instances in a staggered order
module "ec2-stop-phase1" {
  source               = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/auto-start/lambda-scheduler-stop-start?ref=terraform-0.12"
  name                 = "${local.environment_name}-stop-ec2-phase1"
  schedule_action      = var.schedule_stop_action
  spot_schedule        = var.spot_schedule
  ec2_schedule         = var.ec2_schedule
  rds_schedule         = var.rds_schedule
  autoscaling_schedule = var.autoscaling_schedule
  environment_name     = local.environment_name

  resources_tag = {
    key   = "autostop"
    value = var.stop_resources_tag_phase1
  }
}

module "ec2-stop-phase2" {
  source               = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/auto-start/lambda-scheduler-stop-start?ref=terraform-0.12"
  name                 = "${local.environment_name}-stop-ec2-phase2"
  schedule_action      = var.schedule_stop_action
  spot_schedule        = var.spot_schedule
  ec2_schedule         = var.ec2_schedule
  rds_schedule         = var.rds_schedule
  autoscaling_schedule = var.autoscaling_schedule
  environment_name     = local.environment_name

  resources_tag = {
    key   = "autostop"
    value = var.stop_resources_tag_phase2
  }
}
