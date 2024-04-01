package lib.terraform.CB_TFAWS_342

import rego.v1 

test_aws_default_security_group_default_security_group_of_every_vpc_restricts_all_traffic_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_vpc",
				"issue_vpc",
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
				"aws_default_security_group",
				"default",
			],
			"Attributes": {"vpc_id": "aws_vpc.issue_vpc.id"},
			"Blocks": [
				{
					"Type": "ingress",
					"Labels": [],
					"Attributes": {},
					"Blocks": [],
					"line_range": {
						"endLine": 13,
						"startLine": 8,
					},
				},
				{
					"Type": "egress",
					"Labels": [],
					"Attributes": {},
					"Blocks": [],
					"line_range": {
						"endLine": 20,
						"startLine": 15,
					},
				},
			],
			"line_range": {
				"endLine": 21,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_aws_default_security_group_default_security_group_of_every_vpc_restricts_all_traffic_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_vpc",
				"issue_vpc",
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
				"aws_default_security_group",
				"default",
			],
			"Attributes": {"vpc_id": "aws_vpc.issue_vpc.id"},
			"Blocks": [
				{
					"Type": "ingress",
					"Labels": [],
					"Attributes": {
						"from_port": "0",
						"protocol": "-1",
						"self": true,
						"to_port": "0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 13,
						"startLine": 8,
					},
				},
				{
					"Type": "egress",
					"Labels": [],
					"Attributes": {
						"cidr_blocks": ["0.0.0.0/0"],
						"from_port": "0",
						"protocol": "-1",
						"to_port": "0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 20,
						"startLine": 15,
					},
				},
			],
			"line_range": {
				"endLine": 21,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}
