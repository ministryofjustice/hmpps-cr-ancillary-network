# HMPPS Community Rehabilitation Ancillary Applications Network

![DevDeploy](https://codebuild.eu-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiZEZWYkx6UFM3WHdrMGNkcUl1WHUwTmhWNEk5aXRkWS95OHdTbUx4SU9ieG82bUxvVktaSUJVbnZhTHRFY25QYTBYTlVIVkdrTEdOeWluT2UxVDN1bk9rPSIsIml2UGFyYW1ldGVyU3BlYyI6IkxwRzFOaFVaLzRRYzA2OUwiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

Delius Network repo for creating VPC/subnets and shared things for environments.

This will create the base VPC, Subnets and Routes for any Delius environment.
This project has a dependecy on:
https://github.com/ministryofjustice/hmpps-env-configs

## Environment configurations

The environment configurations are to be copied into a directory named `env_configs` with the following example structure:

```
env_configs
├── common
│   ├── common.properties
│   └── common.tfvars
└── cr-jira-prod
    ├── cr-jira-prod.credentials.yml
    ├── cr-jira-prod.properties
    └── cr-jira-prod.tfvars
```

An example method of obtaining the configs would be:

```
CONFIG_BRANCH=master
ENVIRONMENT_NAME=delius-core-dev

mkdir -p env_configs/common
mkdir -p env_configs/${ENVIRONMENT_NAME}

wget "https://raw.githubusercontent.com/ministryofjustice/hmpps-env-configs/${CONFIG_BRANCH}/common/common.properties" --output-document="env_configs/common/common.properties"
wget "https://raw.githubusercontent.com/ministryofjustice/hmpps-env-configs/${CONFIG_BRANCH}/common/common.tfvars" --output-document="env_configs/common/common.tfvars"
wget "https://raw.githubusercontent.com/ministryofjustice/hmpps-env-configs/${CONFIG_BRANCH}/${ENVIRONMENT_NAME}/${ENVIRONMENT_NAME}.properties" --output-document="env_configs/${ENVIRONMENT_NAME}/${ENVIRONMENT_NAME}.properties"
wget "https://raw.githubusercontent.com/ministryofjustice/hmpps-env-configs/${CONFIG_BRANCH}/${ENVIRONMENT_NAME}/${ENVIRONMENT_NAME}.tfvars" --output-document="env_configs/${ENVIRONMENT_NAME}/${ENVIRONMENT_NAME}.tfvars"

source env_configs/${ENVIRONMENT_NAME}/${ENVIRONMENT_NAME}.properties
```

or

```
CONFIG_BRANCH=master
TARGET_DIR=env_configs

git clone --depth 1 -b "${CONFIG_BRANCH}" git@github.com:ministryofjustice/hmpps-env-configs.git "${TARGET_DIR}"
```

## Run order

Start with VPC
then

```
└── vpc
    ├── internetgateway
    │   └── natgateway
    │       └── routes
    └── s3
```

## Network

The subnets are not allocated linearly. The private subnets have much more addresses than the public and database subnets.

The allocation is as per this example for a /20 mask

```
10.163.16.0/20
public
    az1 = 10.163.30.128/25
    az2 = 10.163.31.0/25
    az3 = 10.163.31.128/25
private
    az1 = 10.163.16.0/22
    az2 = 10.163.20.0/22
    az3 = 10.163.24.0/22
db
    az1 = 10.163.28.0/24
    az2 = 10.163.29.0/24
    az3 = 10.163.30.0/25
```

| Subnet address   | Netmask         | Range of addresses            | Useable IPs                   | Hosts |
| ---------------- | --------------- | ----------------------------- | ----------------------------- | ----- |
| 10.163.16.0/22   | 255.255.252.0   | 10.163.16.0 - 10.162.3.255    | 10.163.16.1 - 10.162.3.254    | 1022  |
| 10.162.4.0/22    | 255.255.252.0   | 10.162.4.0 - 10.162.7.255     | 10.162.4.1 - 10.162.7.254     | 1022  |
| 10.162.8.0/22    | 255.255.252.0   | 10.162.8.0 - 10.162.11.255    | 10.162.8.1 - 10.162.11.254    | 1022  |
| 10.162.12.0/24   | 255.255.255.0   | 10.162.12.0 - 10.162.12.255   | 10.162.12.1 - 10.162.12.254   | 254   |
| 10.162.13.0/24   | 255.255.255.0   | 10.162.13.0 - 10.162.13.255   | 10.162.13.1 - 10.162.13.254   | 254   |
| 10.162.14.0/25   | 255.255.255.128 | 10.162.14.0 - 10.162.14.127   | 10.162.14.1 - 10.162.14.126   | 126   |
| 10.162.14.128/25 | 255.255.255.128 | 10.162.14.128 - 10.162.14.255 | 10.162.14.129 - 10.162.14.254 | 126   |
| 10.162.15.0/25   | 255.255.255.128 | 10.162.15.0 - 10.162.15.127   | 10.162.15.1 - 10.162.15.126   | 126   |
| 10.162.15.128/25 | 255.255.255.128 | 10.162.15.128 - 10.162.15.255 | 10.162.15.129 - 10.162.15.254 | 126   |

The proportions are same for smaller cidr range, however a mask smaller than /24 is not recommended.

# INSPEC

[Reference material](https://www.inspec.io/docs/reference/resources/#aws-resources)

## TERRAFORM TESTING

#### Temporary AWS creds

Script **scripts/aws-get-temp-creds.sh** has been written up to automate the process of generating the creds into a file **env_configs/inspec-creds.properties**

#### Usage

```
sh scripts/generate-terraform-outputs.sh
sh scripts/aws-get-temp-creds.sh
source env_configs/inspec-creds.properties
inspec exec ${inspec_profile} -t aws://${TG_REGION}
```

#### To remove the creds

```
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
export AWS_PROFILE=hmpps-token
source env_configs/dev.properties
rm -rf env_configs/inspec-creds.properties
```
