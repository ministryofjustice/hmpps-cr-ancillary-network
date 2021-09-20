locals {

  account_id   = data.terraform_remote_state.vpc.outputs.vpc_account_id
  region       = var.region

  # Change in support of deploy mutiple instance of JitBit on same AWS Account with no impact to exiting Infra
  project_name = var.environment_name != "cr-jitbit-preprod" ? var.project_name : "${var.project_name}-preprod"
  kms_alias    = var.environment_name != "cr-jitbit-preprod" ? "ses-kms-key" : "preprod-ses-kms-key"

  strategic_public_zone_id   = data.terraform_remote_state.vpc.outputs.strategic_public_zone_id
  strategic_public_zone_name = data.terraform_remote_state.vpc.outputs.strategic_public_zone_name

  tags = var.tags

}