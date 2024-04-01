package lib.terraform.CB_TFAWS_057
import rego.v1

test_aws_api_gateway_method_open_access_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_api_gateway_method",
                        "example"
                        ],
                        "Attributes": {
                        "api_key_required": true,
                        "authorization": "AWS_IAM",
                        "http_method": "OPTIONS"
                        },
                        "Blocks": [
                        {
                            "Type": "integration",
                            "Labels": [],
                            "Attributes": {
                            "http_method": "POST",
                            "integration_http_method": "POST",
                            "type": "AWS"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 10,
                            "startLine": 6
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

test_aws_api_gateway_method_open_access_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_api_gateway_method",
                        "example"
                        ],
                        "Attributes": {
                        "api_key_required": false,
                        "authorization": "NONE",
                        "http_method": "GET"
                        },
                        "Blocks": [
                        {
                            "Type": "integration",
                            "Labels": [],
                            "Attributes": {
                            "http_method": "POST",
                            "integration_http_method": "POST",
                            "type": "AWS"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 10,
                            "startLine": 6
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