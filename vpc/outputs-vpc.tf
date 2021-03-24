output "vpc_subnet" {
  value = {
    az1 = {
      zone = {
        public  = module.public_subnet_az1.availability_zone,
        private = module.private_subnet_az1.availability_zone
        db      = module.db_subnet_az1.availability_zone
      },
      cidr = {
        public  = module.public_subnet_az1.subnet_cidr,
        private = module.private_subnet_az1.subnet_cidr,
        db      = module.db_subnet_az1.subnet_cidr
      },
      id = {
        public  = module.public_subnet_az1.subnetid,
        private = module.private_subnet_az1.subnetid,
        db      = module.db_subnet_az1.subnetid
      }
    },
    az2 = {
      zone = {
        public  = module.public_subnet_az2.availability_zone,
        private = module.private_subnet_az2.availability_zone
        db      = module.db_subnet_az2.availability_zone
      },
      cidr = {
        public  = module.public_subnet_az2.subnet_cidr,
        private = module.private_subnet_az2.subnet_cidr,
        db      = module.db_subnet_az2.subnet_cidr
      },
      id = {
        public  = module.public_subnet_az2.subnetid,
        private = module.private_subnet_az2.subnetid,
        db      = module.db_subnet_az2.subnetid
      }
    },
    az3 = {
      zone = {
        public  = module.public_subnet_az3.availability_zone,
        private = module.private_subnet_az3.availability_zone
        db      = module.db_subnet_az3.availability_zone
      },
      cidr = {
        public  = module.public_subnet_az3.subnet_cidr,
        private = module.private_subnet_az3.subnet_cidr,
        db      = module.db_subnet_az3.subnet_cidr
      },
      id = {
        public  = module.public_subnet_az3.subnetid,
        private = module.private_subnet_az3.subnetid,
        db      = module.db_subnet_az3.subnetid
      }
    }
  }
}

output "vpc_subnet_cidr" {
  value = {
    vpc = module.vpc.vpc_cidr,
    public = {
      az1 = module.public_subnet_az1.subnet_cidr,
      az2 = module.public_subnet_az2.subnet_cidr,
      az3 = module.public_subnet_az3.subnet_cidr,
    },
    private = {
      az1 = module.private_subnet_az1.subnet_cidr,
      az2 = module.private_subnet_az2.subnet_cidr,
      az3 = module.private_subnet_az3.subnet_cidr,
    },
    db = {
      az1 = module.db_subnet_az1.subnet_cidr,
      az2 = module.db_subnet_az2.subnet_cidr,
      az3 = module.db_subnet_az3.subnet_cidr,
    }
  }
}