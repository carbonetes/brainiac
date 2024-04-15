package lib.terraform.CB_TFIBM_002

import rego.v1

test_tfibm_api_gateway_endpoint_passed if {
	result := passed with input as [
    {
        "Attributes": {
            "location": "global",
            "name": "Test",
            "plan": "lite",
            "service": "api-gateway"
        },
        "Blocks": [],
        "Labels": [
            "ibm_resource_instance",
            "apigateway"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "managed": true,
            "name": "test-endpoint",
            "open_api_doc_name": "var.file_path",
            "service_instance_crn": "ibm_resource_instance.apigateway.id",
            "type": "share"
        },
        "Blocks": [],
        "Labels": [
            "ibm_api_gateway_endpoint",
            "endpoint"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 14,
            "startLine": 8
        }
    }
]
	count(result) == 1
}

test_tfibm_api_gateway_endpoint_failed if {
	result := failed with input as [
    {
        "Attributes": {
            "location": "global",
            "name": "Test",
            "plan": "lite",
            "service": "api-gateway"
        },
        "Blocks": [],
        "Labels": [
            "ibm_resource_instance",
            "apigateway"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "managed": false,
            "name": "test-endpoint",
            "open_api_doc_name": "var.file_path",
            "service_instance_crn": "ibm_resource_instance.apigateway.id",
            "type": "share"
        },
        "Blocks": [],
        "Labels": [
            "ibm_api_gateway_endpoint",
            "endpoint"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 14,
            "startLine": 8
        }
    }
]
	count(result) == 1
}