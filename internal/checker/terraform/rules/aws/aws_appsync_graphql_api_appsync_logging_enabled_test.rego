package lib.terraform.CB_TFAWS_184
import rego.v1

test_aws_appsync_graphql_api_appsync_logging_enabled_passed if {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_appsync_graphql_api",
                                    "enabled"
                                    ],
                                    "Attributes": {
                                    "authentication_type": "API_KEY",
                                    "name": "example"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "log_config",
                                        "Labels": [],
                                        "Attributes": {
                                        "cloudwatch_logs_role_arn": "aws_iam_role.example.arn",
                                        "field_log_level": "ERROR"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 8,
                                        "startLine": 5
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 9,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_appsync_graphql_api_appsync_logging_enabled_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_appsync_graphql_api",
                                    "enabled"
                                    ],
                                    "Attributes": {
                                    "authentication_type": "API_KEY",
                                    "name": "example"
                                    },
                                    "line_range": {
                                    "endLine": 9,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
