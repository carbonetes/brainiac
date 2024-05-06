package lib.terraform.CB_TFAWS_313

import rego.v1

test_ec2_transit_gateway_auto_accept_passed if {
	result := passed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-east-1"
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
            "aws_ec2_transit_gateway",
            "example"
        ],
        "Attributes": {
            "auto_accept_shared_attachments": "disable",
            "description": "Example Transit Gateway"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    },
    {
        "Type": "output",
        "Labels": [
            "transit_gateway_id"
        ],
        "Attributes": {
            "value": "aws_ec2_transit_gateway.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 12
        }
    }
]
	count(result) == 1
}

test_ec2_transit_gateway_auto_accept_failed if {
	result := failed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-east-1"
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
            "aws_ec2_transit_gateway",
            "example"
        ],
        "Attributes": {
            "auto_accept_shared_attachments": "enable",
            "description": "Example Transit Gateway"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    },
    {
        "Type": "output",
        "Labels": [
            "transit_gateway_id"
        ],
        "Attributes": {
            "value": "aws_ec2_transit_gateway.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 12
        }
    }
]
	count(result) == 1
}