package lib.terraform.CB_TFNCP_003

test_ncloud_access_control_group_rule_outbound_traffic_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_access_control_group_rule",
			"example",
		],
		"Attributes": {
			"access_control_group_id": "ncloud_access_control_group.example.id",
			"action": "ACCEPT",
			"description": "Allow outbound traffic",
			"name": "example-rule",
			"priority": "100",
		},
		"Blocks": [{
			"Type": "outbound",
			"Labels": [],
			"Attributes": {"ip_block": ["192.168.0.0/24"]},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_access_control_group_rule_outbound_traffic_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_access_control_group_rule",
			"example",
		],
		"Attributes": {
			"access_control_group_id": "ncloud_access_control_group.example.id",
			"action": "ACCEPT",
			"description": "Allow outbound traffic",
			"name": "example-rule",
			"priority": "100",
		},
		"Blocks": [{
			"Type": "outbound",
			"Labels": [],
			"Attributes": {"ip_block": ["0.0.0.0/0"]},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
