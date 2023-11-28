package lib.terraform.CB_TFALI_002

test_alicloud_security_group_rule_ingress_restricted_port_22_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_security_group_rule",
			"restrict_ssh_ingress",
		],
		"Attributes": {
			"cidr_ip": "0.0.0.0/0",
			"ip_protocol": "tcp",
			"nic_type": "internet",
			"policy": "drop",
			"port_range": "5900/5900",
			"security_group_id": "alicloud_security_group.default.id",
			"type": "ingress",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_security_group_rule_ingress_restricted_port_22_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_security_group_rule",
			"restrict_ssh_ingress",
		],
		"Attributes": {
			"cidr_ip": "0.0.0.0/0",
			"ip_protocol": "tcp",
			"nic_type": "internet",
			"policy": "drop",
			"port_range": "22/22",
			"security_group_id": "alicloud_security_group.default.id",
			"type": "ingress",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
