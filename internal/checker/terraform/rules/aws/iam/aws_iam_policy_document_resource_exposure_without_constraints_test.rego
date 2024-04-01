package lib.terraform.CB_TFAWS_115
import rego.v1

test_aws_iam_policy_document_resource_exposure_without_constraints_passed if {
    result := passed with input as [
                                    {
                                    "Type": "data",
                                    "Labels": [
                                    "aws_iam_policy_document",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "statement",
                                        "Labels": [],
                                        "Attributes": {
                                        "actions": [
                                        "s3:*"
                                        ],
                                        "effect": "Allow",
                                        "resources": [
                                        "foo"
                                        ],
                                        "sid": "1"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_iam_policy_document_resource_exposure_without_constraints_failed if {
result := failed with input as [
                                    {
                                    "Type": "data",
                                    "Labels": [
                                    "aws_iam_policy_document",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "statement",
                                        "Labels": [],
                                        "Attributes": {
                                        "actions": [
                                        "iam:*",
                                        "ec2:*",
                                        "s3:*",
                                        "sns:*",
                                        "sqs:*",
                                        "lambda:*",
                                        "kms:*",
                                        "cloudformation:*",
                                        "rds:*",
                                        "*"
                                        ],
                                        "effect": "Allow",
                                        "resources": [
                                        "*"
                                        ],
                                        "sid": "1"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
                  