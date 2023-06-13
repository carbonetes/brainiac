package lib.terraform.CB_TFAWS_107

test_aws_glue_security_configuration_encrypted_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_glue_security_configuration",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "name": "example"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "encryption_configuration",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "cloudwatch_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                        "cloudwatch_encryption_mode": "SSE-KMS",
                                        "kms_key_arn": "aws_kms_key.example.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 8,
                                        "startLine": 5
                                        }
                                        },
                                        {
                                        "Type": "job_bookmarks_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                        "job_bookmarks_encryption_mode": "CSE-KMS",
                                        "kms_key_arn": "aws_kms_key.example.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 13,
                                        "startLine": 10
                                        }
                                        },
                                        {
                                        "Type": "s3_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                        "s3_encryption_mode": "SSE-KMS",
                                        "kms_key_arn": "aws_kms_key.example.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 18,
                                        "startLine": 15
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 19,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 20,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_glue_security_configuration_encrypted_failed {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_glue_security_configuration",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "name": "example"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "encryption_configuration",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "cloudwatch_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                       
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 8,
                                        "startLine": 5
                                        }
                                        },
                                        {
                                        "Type": "job_bookmarks_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                        
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 13,
                                        "startLine": 10
                                        }
                                        },
                                        {
                                        "Type": "s3_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                       
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 18,
                                        "startLine": 15
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 19,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 20,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
                  