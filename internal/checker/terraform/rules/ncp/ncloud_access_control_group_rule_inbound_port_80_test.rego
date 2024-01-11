package lib.terraform.CB_TFNCP_024

test_ncloud_access_control_group_rule_inbound_port_80_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_access_control_group_rule",
			"example_rule",
		],
		"Attributes": {
			"access_control_group_id": "ncloud_access_control_group.example.id",
			"action": "ACCEPT",
			"name": "example-rule",
			"priority": "100",
		},
		"Blocks": [{
			"Type": "inbound",
			"Labels": [],
			"Attributes": {
				"from_port": "0",
				"source_ip": "192.168.0.0/24",
				"to_port": "80",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 11,
			},
		}],
		"line_range": {
			"endLine": 16,
			"startLine": 5,
		},
	}]
	count(result) == 1
}

test_ncloud_access_control_group_rule_inbound_port_80_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_access_control_group_rule",
			"example_rule",
		],
		"Attributes": {
			"access_control_group_id": "ncloud_access_control_group.example.id",
			"action": "ACCEPT",
			"name": "example-rule",
			"priority": "100",
		},
		"Blocks": [{
			"Type": "inbound",
			"Labels": [],
			"Attributes": {
				"from_port": "0",
				"source_ip": "0.0.0.0/0",
				"to_port": "80",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 11,
			},
		}],
		"line_range": {
			"endLine": 16,
			"startLine": 5,
		},
	}]
	count(result) == 1
}
