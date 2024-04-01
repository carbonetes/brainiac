package lib.terraform.CB_TFAWS_253

import rego.v1

test_aws_security_group_no_security_groups_allow_ingress_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_security_group",
			"example",
		],
		"Attributes": {"name": "allow-all-ingress"},
		"Blocks": [{
			"Type": "ingress",
			"Labels": [],
			"Attributes": {
				"cidr_blocks": ["0.0.0.0/0"],
				"from_port": "443",
				"protocol": "tcp",
				"to_port": "443",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_security_group_no_security_groups_allow_ingress_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_security_group",
			"example",
		],
		"Attributes": {"name": "allow-all-ingress"},
		"Blocks": [{
			"Type": "ingress",
			"Labels": [],
			"Attributes": {
				"cidr_blocks": ["0.0.0.0/0"],
				"from_port": "-1",
				"protocol": "tcp",
				"to_port": "-1",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
