package lib.terraform.CB_TFLIN_005

test_linode_firewall_outbound_not_set_accept_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"linode_firewall",
			"example",
		],
		"Attributes": {
			"outbound_policy": "DROP",
			"name": "example-firewall",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_linode_firewall_outbound_not_set_accept_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"linode_firewall",
			"example",
		],
		"Attributes": {
			"outbound_policy": "ACCEPT",
			"name": "example-firewall",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
