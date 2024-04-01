package lib.terraform.CB_TFAWS_046
import rego.v1

test_security_group_from_port_3389_set_properly if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_security_group",
			"example",
		],
		"Attributes": {"name_prefix": "example-security-group"},
		"Blocks": [{
			"Type": "ingress",
			"Labels": [],
			"Attributes": {
				"cidr_blocks": ["0.0.0.0/32"],
				"from_port": "0",
				"protocol": "tcp",
				"to_port": "3389",
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

test_security_group_from_port_3389_not_set_properly if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_security_group",
			"example",
		],
		"Attributes": {"name_prefix": "example-security-group"},
		"Blocks": [{
			"Type": "ingress",
			"Labels": [],
			"Attributes": {
				"cidr_blocks": ["0.0.0.0/0"],
				"from_port": "0",
				"protocol": "tcp",
				"to_port": "3389",
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
