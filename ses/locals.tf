locals {

  account_id = data.terraform_remote_state.vpc.outputs.vpc_account_id
  region     = var.region

  # Change in support of deploy mutiple instance of JitBit on same AWS Account with no impact to exiting Infra
  env_prefix   = replace("${var.environment_type}", "jitbit-", "")
  project_name = var.environment_name != "cr-jitbit-dev" ? "${var.project_name}-${local.env_prefix}" : var.project_name
  kms_alias    = var.environment_name != "cr-jitbit-dev" ? "${local.env_prefix}-ses-kms-key" : "ses-kms-key"

  strategic_public_zone_id   = data.terraform_remote_state.vpc.outputs.strategic_public_zone_id
  strategic_public_zone_name = data.terraform_remote_state.vpc.outputs.strategic_public_zone_name

  tags = var.tags

}