resource "aws_ses_domain_identity" "ses_domain_identity" {
  domain = local.strategic_public_zone_name
}

resource "aws_route53_record" "ses_verification_record" {
  zone_id = local.strategic_public_zone_id
  name    = "_amazonses.${local.strategic_public_zone_name}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses_domain_identity.verification_token]
}

resource "aws_ses_domain_identity_verification" "ses_verify" {
  domain = aws_ses_domain_identity.ses_domain_identity.id

  depends_on = [aws_route53_record.ses_verification_record]
}

resource "aws_ses_domain_dkim" "dkim_records" {
  domain = aws_ses_domain_identity.ses_domain_identity.domain
}

resource "aws_route53_record" "amazonses_verification_record_dkim" {
  count   = 3
  zone_id = local.strategic_public_zone_id
  name    = "${element(aws_ses_domain_dkim.dkim_records.dkim_tokens, count.index)}._domainkey.${aws_ses_domain_identity.ses_domain_identity.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim_records.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_ses_domain_mail_from" "ses_mail_from" {
  domain           = aws_ses_domain_identity.ses_domain_identity.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.ses_domain_identity.domain}"
}

resource "aws_route53_record" "ses_mx_record" {
  zone_id = local.strategic_public_zone_id
  name    = aws_ses_domain_mail_from.ses_mail_from.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.eu-west-1.amazonses.com"]
}

resource "aws_route53_record" "ses_spf_record" {
  zone_id = local.strategic_public_zone_id
  name    = aws_ses_domain_mail_from.ses_mail_from.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}
