package lib.terraform.CB_TFIBM_087

import rego.v1

test_tfibm_api_gateway_endpoint_subscriptions_api_key_supported_type_passed if {
	result := passed with input as [
    {
        "Type": "data",
        "Labels": [
            "ibm_api_gateway",
            "endpoint"
        ],
        "Attributes": {
            "service_instance_crn": "ibm_resource_instance.apigateway.id"
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
            "ibm_api_gateway_endpoint_subscription",
            "subs"
        ],
        "Attributes": {
            "artifact_id": "data.ibm_api_gateway.endpoint.endpoints..endpoint_id",
            "client_id": "testid",
            "generate_secret": true,
            "name": "testname",
            "type": "external"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 5
        }
    },
    {
        "Type": "data",
        "Labels": [
            "ibm_api_gateway",
            "endpoint"
        ],
        "Attributes": {
            "service_instance_crn": "ibm_resource_instance.apigateway.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 15,
            "startLine": 13
        }
    }
]
	count(result) == 1
}

test_tfibm_api_gateway_endpoint_subscriptions_api_key_supported_type_failed if {
	result := failed with input as [
    {
        "Type": "data",
        "Labels": [
            "ibm_api_gateway",
            "endpoint"
        ],
        "Attributes": {
            "service_instance_crn": "ibm_resource_instance.apigateway.id"
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
            "ibm_api_gateway_endpoint_subscription",
            "subs"
        ],
        "Attributes": {
            "artifact_id": "data.ibm_api_gateway.endpoint.endpoints..endpoint_id",
            "client_id": "testid",
            "generate_secret": true,
            "name": "testname",
            "type": "externall"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 5
        }
    },
    {
        "Type": "data",
        "Labels": [
            "ibm_api_gateway",
            "endpoint"
        ],
        "Attributes": {
            "service_instance_crn": "ibm_resource_instance.apigateway.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 15,
            "startLine": 13
        }
    }
]
	count(result) == 1
}
