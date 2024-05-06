package lib.terraform.CB_TFAWS_205
import rego.v1

test_aws_api_gateway_domain_name_api_gateway_domain_utilizing_modern_security_policy_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_api_gateway_domain_name",
                        "example"
                        ],
                        "Attributes": {
                        "security_policy": "TLS_1_2"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 5,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_api_gateway_domain_name_api_gateway_domain_utilizing_modern_security_policy_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_api_gateway_domain_name",
                        "example"
                        ],
                        "Attributes": {
                        "security_policy": ""
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 5,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}