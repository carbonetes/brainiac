package lib.terraform.CB_TFAWS_185

test_aws_appsync_graphql_api_field_level_logs_enabled_passed {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_appsync_graphql_api",
                                    "all"
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
                                        "field_log_level": "ALL"
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

test_aws_appsync_graphql_api_field_level_logs_enabled_failed {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_appsync_graphql_api",
                                    "all"
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
                                        "field_log_level": ""
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
