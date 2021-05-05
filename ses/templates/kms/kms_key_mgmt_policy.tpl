{
    "Version": "2012-10-17",
    "Id": "SES Key Management Policy",
    "Statement": [
        {
            "Sid": "EnableAccountOwnerPermissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${aws_account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "EnableTerraformBuilderPermissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${aws_account_id}:role/terraform"
                ]
            },
            "Action": [
                "kms:Create*",
                "kms:Describe*",
                "kms:Enable*",
                "kms:List*",
                "kms:Put*",
                "kms:Update*",
                "kms:Revoke*",
                "kms:Disable*",
                "kms:Get*",
                "kms:Delete*",
                "kms:TagResource",
                "kms:UntagResource",
                "kms:ScheduleKeyDeletion",
                "kms:CancelKeyDeletion"
            ],
            "Resource": "*"
        }
    ]
}
