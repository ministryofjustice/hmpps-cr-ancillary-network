output "natgateway_common-nat-id-az1" {
  value = module.common-nat-az1.natid
}

output "natgateway_common-nat-id-az2" {
  value = module.common-nat-az2.natid
}

output "natgateway_common-nat-id-az3" {
  value = module.common-nat-az3.natid
}

output "natgateway_common-nat-public-ip-az1" {
  value = module.common-nat-az1.nat_public_ip
}

output "natgateway_common-nat-public-ip-az2" {
  value = module.common-nat-az2.nat_public_ip
}

output "natgateway_common-nat-public-ip-az3" {
  value = module.common-nat-az3.nat_public_ip
}

output "natgateway_common-nat-private-ip-az1" {
  value = module.common-nat-az1.nat_private_ip
}

output "natgateway_common-nat-private-ip-az2" {
  value = module.common-nat-az2.nat_private_ip
}

output "natgateway_common-nat-private-ip-az3" {
  value = module.common-nat-az3.nat_private_ip
}

output "this" {
  value = {
    az1 = {
      id         = module.common-nat-az1.natid,
      private_ip = module.common-nat-az1.nat_private_ip,
      public_ip  = module.common-nat-az1.nat_public_ip
    },
    az2 = {
      id         = module.common-nat-az2.natid,
      private_ip = module.common-nat-az2.nat_private_ip,
      public_ip  = module.common-nat-az2.nat_public_ip
    },
    az3 = {
      id         = module.common-nat-az3.natid,
      private_ip = module.common-nat-az3.nat_private_ip,
      public_ip  = module.common-nat-az3.nat_public_ip
    },
    ids = [
      module.common-nat-az1.natid,
      module.common-nat-az2.natid,
      module.common-nat-az3.natid
    ],
    private_ips = [
      module.common-nat-az1.nat_private_ip,
      module.common-nat-az2.nat_private_ip,
      module.common-nat-az3.nat_private_ip
    ],
    public_ips = [
      module.common-nat-az1.nat_public_ip,
      module.common-nat-az2.nat_public_ip,
      module.common-nat-az3.nat_public_ip
    ]
  }
}
