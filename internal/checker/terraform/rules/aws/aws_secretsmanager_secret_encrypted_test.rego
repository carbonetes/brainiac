package lib.terraform.CB_TFAWS_124

test_aws_secretsmanager_secret_passed {
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

test_aws_secretsmanager_secret_failed {
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