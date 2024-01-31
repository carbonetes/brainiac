package lib.terraform.CB_TFOPENSTACK_005

test_openstack_fw_rule_v1_destination_ip_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"openstack_fw_rule_v1",
			"fail",
		],
		"Attributes": {
			"action": "allow",
			"description": "let anyone in",
			"destination_ip_address": "10.0.0.1",
			"destination_port": "22",
			"enabled": "true",
			"name": "my_rule_world",
			"protocol": "tcp",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_openstack_fw_rule_v1_destination_ip_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"openstack_fw_rule_v1",
			"fail",
		],
		"Attributes": {
			"action": "allow",
			"description": "let anyone in",
			"destination_port": "22",
			"enabled": "true",
			"name": "my_rule_world",
			"protocol": "tcp",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
