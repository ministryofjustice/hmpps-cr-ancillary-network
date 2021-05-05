locals {
  remove_prod             = replace("${var.environment_type}", "-prod", "")
  subdomain               = replace("${local.remove_prod}", "-", ".")
  route53_internal_domain = "${local.subdomain}.${var.project_name}.internal"
  # public_domain           = "${var.subdomain}.${var.route53_domain_private}"
  strategic_public_domain = "${local.subdomain}.${var.project_name}.probation.${var.public_dns_parent_zone}"
}

# Private internal zone for easier lookups
resource "aws_route53_zone" "internal_zone" {
  name = local.route53_internal_domain

  vpc {
    vpc_id = module.vpc.vpc_id
  }
  tags = merge(
    var.tags,
    {
      "Name" = local.route53_internal_domain,
      "Type" = "internal"
    },
  )
}

# Existing *.delius.probation.hmpps.dsd.io public domain
# data "aws_route53_zone" "public_hosted_zone" {
#   name = local.public_domain
# }

# data "aws_acm_certificate" "ssl_certificate_details" {
#   domain      = "*.${local.public_domain}"
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }

# Strategic *.probation.service.justice.gov.uk public domain
resource "aws_route53_zone" "strategic_zone" {
  name = local.strategic_public_domain
  tags = merge(
    var.tags,
    {
      "Name" = local.strategic_public_domain,
      "Type" = "public"
    },
  )
}

# # Delegation record so we can access the strategic route53 zone from prod
# resource "aws_route53_record" "delegation_record" {
#
#   # The zone id of the prod R53 zone
#   zone_id = var.strategic_parent_zone_id
#   name    = local.strategic_public_domain
#   type    = "NS"
#   ttl     = "300"
#   records = aws_route53_zone.strategic_zone[0].name_servers
#
#   # Use alternative provider which assumes cross account role in prod for managing R53 records
#   provider = aws.delius_prod_acct_r53_delegation
# }

resource "aws_acm_certificate" "cert" {
  domain_name       = "*.${local.strategic_public_domain}"
  validation_method = "DNS"
  tags = merge(
    var.tags,
    {
      "Name" = local.strategic_public_domain
    },
  )
  lifecycle {
    create_before_destroy = true
  }
}

# # Validation record for the strategic ssl cert
# resource "aws_route53_record" "cert_validation" {
#   zone_id    = aws_route53_zone.strategic_zone[0].zone_id
#   name       = aws_acm_certificate.cert[0].domain_validation_options[0].resource_record_name
#   type       = aws_acm_certificate.cert[0].domain_validation_options[0].resource_record_type
#   records    = [aws_acm_certificate.cert[0].domain_validation_options[0].resource_record_value]
#   ttl        = 60
#   depends_on = [aws_acm_certificate.cert]
# }
#
# # This resource allows terraform to wait till the certificate has been validated using the above r53 record
# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = aws_acm_certificate.cert[0].arn
#   validation_record_fqdns = [aws_route53_record.cert_validation[0].fqdn]
# }
