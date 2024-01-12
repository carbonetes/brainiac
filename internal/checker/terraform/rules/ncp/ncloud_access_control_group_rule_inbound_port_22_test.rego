package lib.terraform.CB_TFNCP_004

test_ncloud_access_control_group_rule_inbound_port_22_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_access_control_group_rule",
			"example",
		],
		"Attributes": {
			"access_control_group_id": "ncloud_access_control_group.example.id",
			"action": "ACCEPT",
			"description": "Allow inbound traffic on port 22",
			"name": "example-rule",
			"priority": "100",
		},
		"Blocks": [{
			"Type": "inbound",
			"Labels": [],
			"Attributes": {
				"cidr_block": ["192.168.0.0/24"],
				"from_port": "22",
				"protocol": "TCP",
				"to_port": "22",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_access_control_group_rule_inbound_port_22_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_access_control_group_rule",
			"example",
		],
		"Attributes": {
			"access_control_group_id": "ncloud_access_control_group.example.id",
			"action": "ACCEPT",
			"description": "Allow inbound traffic on port 22",
			"name": "example-rule",
			"priority": "100",
		},
		"Blocks": [{
			"Type": "inbound",
			"Labels": [],
			"Attributes": {
				"cidr_block": ["0.0.0.0/0"],
				"from_port": "22",
				"protocol": "TCP",
				"to_port": "22",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
