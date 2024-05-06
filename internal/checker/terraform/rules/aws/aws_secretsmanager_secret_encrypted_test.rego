package lib.terraform.CB_TFAWS_124
import rego.v1

test_aws_secretsmanager_secret_passed if{
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_secretsmanager_secret",
                                "enabled"
                                ],
                                "Attributes": {
                                "kms_key_id": "var.kms_key_id"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 4,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}

test_aws_secretsmanager_secret_failed if{
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_secretsmanager_secret",
                                "enabled"
                                ],
                                "Attributes": {
                       
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 4,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}