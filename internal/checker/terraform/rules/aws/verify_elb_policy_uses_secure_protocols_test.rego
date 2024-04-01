package lib.terraform.CB_TFAWS_197
import rego.v1

test_elb_policy_uses_secure_protocol if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_load_balancer_policy",
			"pass",
		],
		"Attributes": {
			"load_balancer_name": "aws_elb.wu-tang.name",
			"policy_name": "wu-tang-ssl",
			"policy_type_name": "SSLNegotiationPolicyType",
		},
		"Blocks": [{
			"Type": "policy_attribute",
			"Labels": [],
			"Attributes": {
				"name": "Protocol-SSLv3",
				"value": "false",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_elb_policy_not_uses_secure_protocol if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_load_balancer_policy",
			"pass",
		],
		"Attributes": {
			"load_balancer_name": "aws_elb.wu-tang.name",
			"policy_name": "wu-tang-ssl",
			"policy_type_name": "SSLNegotiationPolicyType",
		},
		"Blocks": [{
			"Type": "policy_attribute",
			"Labels": [],
			"Attributes": {
				"name": "Protocol-SSLv3",
				"value": "true",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
