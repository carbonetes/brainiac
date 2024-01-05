package lib.terraform.CB_TFNCP_010

test_ncloud_network_acl_rule_inbound_port_22_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_network_acl_rule",
			"example",
		],
		"Attributes": {
			"from_port": "22",
			"ipv4_cidr": "192.168.1.1/32",
			"network_acl_id": "ncloud_network_acl.example.id",
			"protocol": "-1",
			"rule_action": "allow",
			"rule_number": "20",
			"to_port": "22",
		},
		"Blocks": [{
			"Type": "inbound",
			"Labels": [],
			"Attributes": {
				"from_port": "22",
				"ipv4_cidr": "192.168.1.1/32",
				"protocol": "tcp",
				"rule_action": "allow",
				"to_port": "22",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 18,
				"startLine": 12,
			},
		}],
		"line_range": {
			"endLine": 19,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_network_acl_rule_inbound_port_22_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_network_acl_rule",
			"example",
		],
		"Attributes": {
			"from_port": "22",
			"ipv4_cidr": "192.168.1.1/32",
			"network_acl_id": "ncloud_network_acl.example.id",
			"protocol": "-1",
			"rule_action": "allow",
			"rule_number": "21",
			"to_port": "22",
		},
		"Blocks": [{
			"Type": "inbound",
			"Labels": [],
			"Attributes": {
				"from_port": "22",
				"ipv4_cidr": "0.0.0.0/0",
				"protocol": "tcp",
				"rule_action": "allow",
				"to_port": "22",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 18,
				"startLine": 12,
			},
		}],
		"line_range": {
			"endLine": 19,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
