package lib.terraform.CB_TFAWS_102
import rego.v1

test_aws_iam_policy_document_constraints_restricted_passed if {
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
                                        "effect": "Deny",
                                        "resources": [
                                        "foo"
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

test_aws_iam_policy_document_constraints_restricted_failed if {
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
                                        "s3:*",
                                        "S3:PutObject",
                                        "dynamodb:PutItem",
                                        "sns:Publish",
                                        "sqs:SendMessage",
                                        "lambda:InvokeFunction",
                                        "rds:CreateDBInstance",
                                        "ec2:RunInstances",
                                        "cloudformation:CreateStack",  
                                        "sagemaker:CreateTrainingJob",  
                                        "kinesis:PutRecord"
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
                  