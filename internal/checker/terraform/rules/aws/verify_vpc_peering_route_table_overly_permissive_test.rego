package lib.terraform.CB_TFAWS_333

test_vpc_peering_route_table_overly_permissive_passed {
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
            "aws_route",
            "aws_route_pass_1"
        ],
        "Attributes": {
            "destination_cidr_block": "10.0.1.0/22",
            "route_table_id": "aws_route_table.route_table.id",
            "vpc_peering_connection_id": "aws_vpc_peering_connection.peering.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }
]
	count(result) == 1
}

test_vpc_peering_route_table_overly_permissive_failed {
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
            "aws_route",
            "aws_route_pass_1"
        ],
        "Attributes": {
            "destination_cidr_block": "0.0.0.0/0",
            "route_table_id": "aws_route_table.route_table.id",
            "vpc_peering_connection_id": "aws_vpc_peering_connection.peering.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }
]
	count(result) == 1
}