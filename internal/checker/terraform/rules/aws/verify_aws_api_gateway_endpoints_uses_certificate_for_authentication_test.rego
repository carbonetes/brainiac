package lib.terraform.CB_TFAWS_368

test_aws_api_gateway_endpoints_uses_certificate_for_authentication_passed {
	result := passed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_apigatewayv2_api",
            "example_api"
        ],
        "Attributes": {
            "name": "example-api",
            "protocol_type": "HTTP"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_apigatewayv2_stage",
            "example_stage"
        ],
        "Attributes": {
            "api_id": "aws_apigatewayv2_api.example_api.id",
            "name": "example-stage"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 10
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_client_certificate",
            "example_certificate"
        ],
        "Attributes": {
            "description": "Example client certificate"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 15
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_domain_name",
            "example_domain"
        ],
        "Attributes": {
            "certificate_arn": "aws_api_gateway_client_certificate.example_certificate.arn",
            "domain_name": "example-api-domain.com"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_base_path_mapping",
            "example_mapping"
        ],
        "Attributes": {
            "domain_name": "aws_api_gateway_domain_name.example_domain.domain_name",
            "stage_name": "aws_apigatewayv2_stage.example_stage.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 27,
            "startLine": 24
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_integration",
            "example_integration"
        ],
        "Attributes": {
            "api_id": "aws_apigatewayv2_api.example_api.id",
            "connection_type": "INTERNET",
            "integration_type": "HTTP_PROXY",
            "integration_uri": "https://example-backend.com"
        },
        "Blocks": [
            {
                "Type": "tls_config",
                "Labels": [],
                "Attributes": {
                    "insecure_skip_verification": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 36,
                    "startLine": 34
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 29
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_route",
            "example_route"
        ],
        "Attributes": {
            "api_id": "aws_apigatewayv2_api.example_api.id",
            "route_key": "GET /",
            "target": "aws_api_gateway_integration.example_integration.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 43,
            "startLine": 39
        }
    },
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

test_aws_api_gateway_endpoints_uses_certificate_for_authentication_failed {
	result := failed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_apigatewayv2_api",
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
    {
        "Type": "resource",
        "Labels": [
            "aws_apigatewayv2_stage",
            "example_stage"
        ],
        "Attributes": {
            "api_id": "aws_example_api.example_api.id",
            "name": "example-stage"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 10
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_client_certificate",
            "example_certificate"
        ],
        "Attributes": {
            "description": "Example client certificate"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 15
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_domain_name",
            "example_domain"
        ],
        "Attributes": {
            "certificate_arn": "aws_api_gateway_client_certificate.example_certificate.arn",
            "domain_name": "example-api-domain.com"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_base_path_mapping",
            "example_mapping"
        ],
        "Attributes": {
            "domain_name": "aws_api_gateway_domain_name.example_domain.domain_name",
            "stage_name": "aws_apigatewayv2_stage.example_stage.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 27,
            "startLine": 24
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_integration",
            "example_integration"
        ],
        "Attributes": {
            "api_id": "aws_apigatewayv2_api.example_api.id",
            "connection_type": "INTERNET",
            "integration_type": "HTTP_PROXY",
            "integration_uri": "https://example-backend.com"
        },
        "Blocks": [
            {
                "Type": "tls_config",
                "Labels": [],
                "Attributes": {
                    "insecure_skip_verification": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 36,
                    "startLine": 34
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 29
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_route",
            "example_route"
        ],
        "Attributes": {
            "api_id": "aws_apigatewayv2_api.example_api.id",
            "route_key": "GET /",
            "target": "aws_api_gateway_integration.example_integration.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 43,
            "startLine": 39
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_api_gateway_stage",
            "example_stage"
        ],
        "Attributes": {
            "api_id": "aws_apigatewayv2_api.example_api.id",
            "client_certificate_id": "",
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