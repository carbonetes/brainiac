package lib.terraform.CB_TFAWS_088
import rego.v1

test_aws_iam_policy_document_data_exfiltration_not_allowed_passed if {
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
                                        "effect": "Deny",
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

test_aws_iam_policy_document_data_exfiltration_not_allowed_failed if {
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
                                        "s3:GetObject", 
                                        "ssm:GetParameter",  
                                        "ssm:GetParameters", 
                                        "ssm:GetParametersByPath",
                                        "ssm:GetParameter*", 
                                        "secretsmanager:GetSecretValue"
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
