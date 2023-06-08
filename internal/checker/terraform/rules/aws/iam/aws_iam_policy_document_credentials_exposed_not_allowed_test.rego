package lib.terraform.CB_TFAWS_100

test_aws_iam_policy_document_credentials_exposed_not_allowed_passed {
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
                                        "lambda:CreateFunction",
                                        "lambda:CreateEventSourceMapping",
                                        "dynamodb:CreateTable"
                                        ],
                                        "effect": "Allow",
                                        "resources": [
                                        "*"
                                        ],
                                        "sid": "1"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 13,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 14,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_iam_policy_document_credentials_exposed_not_allowed_failed {
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
                                        "lambda:CreateFunction",
                                        "lambda:CreateEventSourceMapping",
                                        "dynamodb:CreateTable",
                                        "iam:CreateAccessKey"
                                        ],
                                        "effect": "Allow",
                                        "resources": [
                                        "*"
                                        ],
                                        "sid": "1"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 13,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 14,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
