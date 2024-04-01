package lib.terraform.CB_TFAWS_165
import rego.v1

test_aws_lambda_function_lambda_environmental_variable_encryption_settings_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_lambda_function",
                                "test_lambda"
                                ],
                                "Attributes": {
                                "filename": "lambda_function_payload.zip",
                                "function_name": "lambda_function_name",
                                "handler": "index.test",
                                "kms_key_arn": "kms",
                                "role": "aws_iam_role.iam_for_lambda.arn"
                                },
                                "Blocks": [
                                {
                                    "Type": "environment",
                                    "Labels": [],
                                    "Attributes": {
                                    "variables": {
                                    "foo": "bar"
                                    }
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 9
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

test_aws_lambda_function_lambda_environmental_variable_encryption_settings_failed if {
    result := failed with input as [
                            {
                                "Type": "resource",
                                "Labels": [
                                "aws_lambda_function",
                                "test_lambda"
                                ],
                                "Attributes": {
                                "filename": "lambda_function_payload.zip",
                                "function_name": "lambda_function_name",
                                "handler": "index.test",
                                "kms_key_arn": "",
                                "role": "aws_iam_role.iam_for_lambda.arn"
                                },
                                "Blocks": [
                                {
                                    "Type": "environment",
                                    "Labels": [],
                                    "Attributes": {
                                    "variables": {
                                    "foo": "bar"
                                    }
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 9
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