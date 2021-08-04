# VPN VPC PEER CONNECTION

resource "aws_vpc_peering_connection" "peering-vpn-vpc" {
  peer_owner_id = data.terraform_remote_state.vpn.outputs.vpc.account_id
  peer_vpc_id   = data.terraform_remote_state.vpn.outputs.vpc.id
  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment_name}-to-vpn-vpc"
    },
  )
}

# ## Route to VPN private

module "route-to-vpn-vpc-private-cidr-az1" {
  source = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/routes/vpc_peer?ref=terraform-0.12"

  route_table_id = [
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az3,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az3,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az3,
  ]

  destination_cidr_block = data.terraform_remote_state.vpn.outputs.subnet_cidrs.vpn-private-az1
  vpc_peer_id            = aws_vpc_peering_connection.peering-vpn-vpc.id
  create                 = true
}

module "route-to-vpn-vpc-private-cidr-az2" {
  source = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/routes/vpc_peer?ref=terraform-0.12"

  route_table_id = [
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az3,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az3,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az3,
  ]

  destination_cidr_block = data.terraform_remote_state.vpn.outputs.subnet_cidrs.vpn-private-az2
  vpc_peer_id            = aws_vpc_peering_connection.peering-vpn-vpc.id
  create                 = true
}

module "route-to-vpn-vpc-private-cidr-az3" {
  source = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git//modules/routes/vpc_peer?ref=terraform-0.12"

  route_table_id = [
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_public-routetable-az3,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_private-routetable-az3,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az1,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az2,
    data.terraform_remote_state.vpc.outputs.vpc_db-routetable-az3,
  ]

  destination_cidr_block = data.terraform_remote_state.vpn.outputs.subnet_cidrs.vpn-private-az3
  vpc_peer_id            = aws_vpc_peering_connection.peering-vpn-vpc.id
  create                 = true
}
