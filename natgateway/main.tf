data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket_name
    key    = "vpc/terraform.tfstate"
    region = var.region
  }
}

module "common-nat-az1" {
  source = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/natgateway?ref=terraform-0.12"
  az     = "${var.environment_name}-az1"
  subnet = data.terraform_remote_state.vpc.outputs.vpc_public-subnet-az1
  tags   = var.tags
}

module "common-nat-az2" {
  source = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/natgateway?ref=terraform-0.12"
  az     = "${var.environment_name}-az2"
  subnet = data.terraform_remote_state.vpc.outputs.vpc_public-subnet-az2
  tags   = var.tags
}

module "common-nat-az3" {
  source = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/natgateway?ref=terraform-0.12"
  az     = "${var.environment_name}-az3"
  subnet = data.terraform_remote_state.vpc.outputs.vpc_public-subnet-az3
  tags   = var.tags
}
