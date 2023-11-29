package lib.terraform.CB_TFALI_005

test_alicloud_api_gateway_api_protocol_https_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_api_gateway_group",
            "example"
        ],
        "Attributes": {
            "description": "tf-example",
            "name": "tf-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_api_gateway_api",
            "example"
        ],
        "Attributes": {
            "auth_type": "APP",
            "description": "tf-example",
            "force_nonce_check": false,
            "group_id": "alicloud_api_gateway_group.example.id",
            "name": "tf-example",
            "service_type": "HTTP",
            "stage_names": [
                "RELEASE",
                "TEST"
            ]
        },
        "Blocks": [
            {
                "Type": "request_config",
                "Labels": [],
                "Attributes": {
                    "method": "GET",
                    "mode": "MAPPING",
                    "path": "/example/path",
                    "protocol": "HTTPS"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 13
                }
            },
            {
                "Type": "http_service_config",
                "Labels": [],
                "Attributes": {
                    "address": "http://apigateway-backend.alicloudapi.com:8080",
                    "aone_name": "cloudapi-openapi",
                    "method": "GET",
                    "path": "/web/cloudapi",
                    "timeout": "12"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 28,
                    "startLine": 22
                }
            },
            {
                "Type": "request_parameters",
                "Labels": [],
                "Attributes": {
                    "in": "QUERY",
                    "in_service": "QUERY",
                    "name": "example",
                    "name_service": "exampleservice",
                    "required": "OPTIONAL",
                    "type": "STRING"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 37,
                    "startLine": 30
                }
            }
        ],
        "line_range": {
            "endLine": 43,
            "startLine": 6
        }
    }]
	count(result) == 1
}

test_alicloud_api_gateway_api_protocol_https_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_api_gateway_group",
            "example"
        ],
        "Attributes": {
            "description": "tf-example",
            "name": "tf-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_api_gateway_api",
            "example"
        ],
        "Attributes": {
            "auth_type": "APP",
            "description": "tf-example",
            "force_nonce_check": false,
            "group_id": "alicloud_api_gateway_group.example.id",
            "name": "tf-example",
            "service_type": "HTTPS",
            "stage_names": [
                "RELEASE",
                "TEST"
            ]
        },
        "Blocks": [
            {
                "Type": "request_config",
                "Labels": [],
                "Attributes": {
                    "method": "GET",
                    "mode": "MAPPING",
                    "path": "/example/path",
                    "protocol": "HTTP"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 13
                }
            },
            {
                "Type": "http_service_config",
                "Labels": [],
                "Attributes": {
                    "address": "http://apigateway-backend.alicloudapi.com:8080",
                    "aone_name": "cloudapi-openapi",
                    "method": "GET",
                    "path": "/web/cloudapi",
                    "timeout": "12"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 28,
                    "startLine": 22
                }
            },
            {
                "Type": "request_parameters",
                "Labels": [],
                "Attributes": {
                    "in": "QUERY",
                    "in_service": "QUERY",
                    "name": "example",
                    "name_service": "exampleservice",
                    "required": "OPTIONAL",
                    "type": "STRING"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 37,
                    "startLine": 30
                }
            }
        ],
        "line_range": {
            "endLine": 43,
            "startLine": 6
        }
    }]
	count(result) == 1
}
