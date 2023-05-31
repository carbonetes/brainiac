package lib.terraform.CB_TFAWS_069

test_aws_ebs_encryption_by_default_encrypted_passed {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ebs_encryption_by_default",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "enabled": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_ebs_encryption_by_default_encrypted_failed {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ebs_encryption_by_default",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "enabled": false
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
