package lib.terraform.CB_TFAWS_252

import rego.v1 

test_security_group_allow_ingress_port_22 if {
	result := passed with input as [
		{
			"Type": "provider",
			"Labels": ["aws"],
			"Attributes": {"region": "us-east-1"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"example",
			],
			"Attributes": {
				"name_prefix": "example-sg",
				"vpc_id": "vpc-xxxxxxxxxx",
			},
			"Blocks": [
				{
					"Type": "ingress",
					"Labels": [],
					"Attributes": {},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 12,
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
						"endLine": 25,
						"startLine": 20,
					},
				},
			],
			"line_range": {
				"endLine": 26,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_security_group_no_allow_ingress_port_22 if {
	result := failed with input as [
		{
			"Type": "provider",
			"Labels": ["aws"],
			"Attributes": {"region": "us-east-1"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"example",
			],
			"Attributes": {
				"name_prefix": "example-sg",
				"vpc_id": "vpc-xxxxxxxxxx",
			},
			"Blocks": [
				{
					"Type": "ingress",
					"Labels": [],
					"Attributes": {
						"cidr_blocks": ["0.0.0.0/0"],
						"from_port": "80",
						"protocol": "tcp",
						"to_port": "80",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 12,
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
						"endLine": 25,
						"startLine": 20,
					},
				},
			],
			"line_range": {
				"endLine": 26,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}
