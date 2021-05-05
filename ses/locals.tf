locals {

  account_id   = data.terraform_remote_state.vpc.outputs.vpc_account_id
  region       = var.region
  project_name = var.project_name

  strategic_public_zone_id   = data.terraform_remote_state.vpc.outputs.strategic_public_zone_id
  strategic_public_zone_name = data.terraform_remote_state.vpc.outputs.strategic_public_zone_name

  tags = var.tags

}