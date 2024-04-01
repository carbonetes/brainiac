package lib.terraform.CB_TFAWS_333

import rego.v1

test_vpc_peering_route_table_overly_permissive_passed if {
	result := passed with input as [
    {
        "Attributes": {
            "region": "us-east-1"
        },
        "Blocks": [],
        "Labels": [
            "aws"
        ],
        "Type": "provider",
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "destination_cidr_block": "10.0.1.0/22",
            "route_table_id": "aws_route_table.route_table.id",
            "vpc_peering_connection_id": "aws_vpc_peering_connection.peering.id"
        },
        "Blocks": [],
        "Labels": [
            "aws_route",
            "aws_route_pass_1"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }
]
	count(result) == 1
}

test_vpc_peering_route_table_overly_permissive_failed if {
	result := failed with input as [
    {
        "Attributes": {
            "region": "us-east-1"
        },
        "Blocks": [],
        "Labels": [
            "aws"
        ],
        "Type": "provider",
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "destination_cidr_block": "0.0.0.0/0",
            "route_table_id": "aws_route_table.route_table.id",
            "vpc_peering_connection_id": "aws_vpc_peering_connection.peering.id"
        },
        "Blocks": [],
        "Labels": [
            "aws_route",
            "aws_route_pass_1"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }
]
	count(result) == 1
}