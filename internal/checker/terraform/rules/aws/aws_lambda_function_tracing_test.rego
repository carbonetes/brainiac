package lib.terraform.CB_TFAWS_026

test_aws_function_tracing{
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_lambda_function",
                        "example"
                        ],
                        "Attributes": {
                        "function_name": "example-function",
                        "handler": "example.handler",
                        "runtime": "nodejs14.x"
                        },
                        "Blocks": [
                        {
                            "Type": "tracing_config",
                            "Labels": [],
                            "Attributes": {
                            "mode": "Active"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 9,
                            "startLine": 7
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 11,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_function_no_tracing {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_lambda_function",
                        "example"
                        ],
                        "Attributes": {
                        "function_name": "example-function",
                        "handler": "example.handler",
                        "runtime": "nodejs14.x"
                        },
                        "Blocks": [
                        {
                            "Type": "tracing_config",
                            "Labels": [],
                            "Attributes": {
                            "mode": "Inactive"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 9,
                            "startLine": 7
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 11,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}