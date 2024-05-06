package lib.terraform.CB_TFAWS_320

import rego.v1

test_aws_network_acl_nacl_attached_to_subnets_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_vpc",
				"ok_vpc",
			],
			"Attributes": {"cidr_block": "10.0.0.0/16"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_subnet",
				"main",
			],
			"Attributes": {
				"cidr_block": "10.0.1.0/24",
				"vpc_id": "aws_vpc.ok_vpc.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_subnet",
				"main",
			],
			"Attributes": {"cidr_block": "10.0.1.0/24"},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 10,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_network_acl",
				"acl_ok",
			],
			"Attributes": {
				"subnet_ids": "aws_subnet.main.id",
				"vpc_id": "aws_vpc.ok_vpc.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 17,
				"startLine": 14,
			},
		},
	]
	count(result) == 1
}

test_aws_network_acl_nacl_attached_to_subnets_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_network_acl",
			"acl_ok",
		],
		"Attributes": {
			"subnet_ids": "aws_subnet.main.id",
			"vpc_id": "aws_vpc.ok_vpc.id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 17,
			"startLine": 14,
		},
	}]
	count(result) == 1
}
