package lib.terraform.CB_TFAWS_043
import rego.v1

test_securitygroup_has_description if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_security_group",
			"examplea",
		],
		"Attributes": {"description": "Allow inbound traffic to ElasticSearch from VPC CIDR"},
		"Blocks": [{
			"Type": "ingress",
			"Labels": [],
			"Attributes": {
				"cidr_blocks": ["10.0.0.0/16"],
				"description": "What does this rule enable",
				"from_port": "80",
				"protocol": "tcp",
				"to_port": "80",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 7,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
}

test_securitygroup_no_description if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_security_group",
			"examplea",
		],
		"Attributes": {"description": "Allow inbound traffic to ElasticSearch from VPC CIDR"},
		"Blocks": [{
			"Type": "ingress",
			"Labels": [],
			"Attributes": {
				"cidr_blocks": ["10.0.0.0/16"],
				"from_port": "80",
				"protocol": "tcp",
				"to_port": "80",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 7,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
