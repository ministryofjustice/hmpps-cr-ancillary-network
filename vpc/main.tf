provider "aws" {
  alias   = "delius_prod_acct_r53_delegation"
  region  = var.region
  version = "~> 3.33.0"

  # Role in delius prod account for managing R53 NS delegation records
  assume_role {
    role_arn = var.strategic_parent_zone_delegation_role
  }
}

#-------------------------------------------------------------
### Getting the current running account id
#-------------------------------------------------------------
data "aws_caller_identity" "current" {
}

## Lambda to snapshot volumes periodically

module "create_snapshot_lambda" {
  source           = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/ebs-backup?ref=terraform-0.12"
  cron_expression  = "30 1 * * ? *"
  regions          = [var.region]
  rolename_prefix  = var.environment_identifier
  stack_prefix     = var.environment_name
  ec2_instance_tag = "CreateSnapshot"
  unique_name      = "snapshot_ebs_volumes"
  retention_days   = var.snapshot_retention_days
}
