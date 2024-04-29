package lib.terraform.CB_TFIBM_057
import rego.v1

test_resource_group_id_set_passed if {
	result := passed with input as [{
    "Type": "resource",
    "Labels": [
        "ibm_cloudant",
        "cloudant"
    ],
    "Attributes": {
        "capacity": "1",
        "environment_crn": "your_environment_crn_here",
        "id": "your_unique_identifier_here",
        "include_data_events": false,
        "legacy_credentials": false,
        "location": "us-south",
        "name": "cloudant-service-name",
        "parameters": {"key": "value"},
        "plan": "standard",
        "resource_group_id": "your_resource_group_id_here",
        "service_endpoints": "private",
        "tags": [
            "tag1",
            "tag2"
        ]
    },
    "Blocks": [
        {
            "Type": "cors_config",
            "Labels": [],
            "Attributes": {
                "allow_credentials": false,
                "enable_cors": true,
                "origins": ["https://example.com"]
            },
            "Blocks": [],
            "line_range": {
                "endLine": 27,
                "startLine": 23
            }
        },
        {
            "Type": "timeouts",
            "Labels": [],
            "Attributes": {
                "create": "15m",
                "delete": "15m",
                "update": "15m"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 33,
                "startLine": 29
            }
        }
    ],
    "line_range": {
        "endLine": 34,
        "startLine": 1
    }
}]
	count(result) == 1
}

test_resource_group_id_set_failed if {
	result := failed with input as [{
    "Type": "resource",
    "Labels": [
        "ibm_cloudant",
        "cloudant"
    ],
    "Attributes": {
        "capacity": "1",
        "environment_crn": "your_environment_crn_here",
        "id": "your_unique_identifier_here",
        "include_data_events": false,
        "legacy_credentials": false,
        "location": "us-south",
        "name": "cloudant-service-name",
        "parameters": {"key": "value"},
        "plan": "standard",
        "resource_group_id": "",
        "service_endpoints": "public",
        "tags": [
            "tag1",
            "tag2"
        ]
    },
    "Blocks": [
        {
            "Type": "cors_config",
            "Labels": [],
            "Attributes": {
                "allow_credentials": false,
                "enable_cors": false,
                "origins": ["https://example.com"]
            },
            "Blocks": [],
            "line_range": {
                "endLine": 27,
                "startLine": 23
            }
        },
        {
            "Type": "timeouts",
            "Labels": [],
            "Attributes": {
                "create": "15m",
                "delete": "15m",
                "update": "15m"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 33,
                "startLine": 29
            }
        }
    ],
    "line_range": {
        "endLine": 34,
        "startLine": 1
    }
}]
	count(result) == 1
}
