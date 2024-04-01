package lib.terraform.CB_TFAWS_368

import rego.v1 

test_aws_api_gateway_endpoints_uses_certificate_for_authentication_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_stage",
            "example_stage"
        ],
        "Attributes": {
            "api_id": "aws_apigatewayv2_api.example_api.id",
            "client_certificate_id": "aws_api_gateway_client_certificate.example_certificate.id",
            "stage_name": "example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 49,
            "startLine": 45
        }
    }
]
	count(result) == 1
}

test_aws_api_gateway_endpoints_uses_certificate_for_authentication_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_stage",
            "example_api"
        ],
        "Attributes": {
            "name": "example-api",
            "protocol_type": "WEBSOCKET"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
]
	count(result) == 1
}