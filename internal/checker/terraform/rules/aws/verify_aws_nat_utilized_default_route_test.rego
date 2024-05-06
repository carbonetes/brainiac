package lib.terraform.CB_TFAWS_337

import rego.v1

test_aws_nat_utilize_default_route if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_route_table",
			"aws_route_table_ok_1",
		],
		"Attributes": {"vpc_id": "aws_vpc.example.id"},
		"Blocks": [{
			"Type": "route",
			"Labels": [],
			"Attributes": {
				"cidr_block": "0.0.0.0/0",
				"gateway_id": "aws_internet_gateway.example.id",
				"instance_id": "",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_aws_nat_not_utilize_default_route if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_route_table",
			"aws_route_table_ok_1",
		],
		"Attributes": {"vpc_id": "aws_vpc.example.id"},
		"Blocks": [{
			"Type": "route",
			"Labels": [],
			"Attributes": {
				"cidr_block": "0.0.0.0/0",
				"gateway_id": "aws_internet_gateway.example.id",
				"instance_id": "test",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
