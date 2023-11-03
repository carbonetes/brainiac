package lib.terraform.CB_TFAZR_063

test_ssh_access_restricted {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_network_security_rule",
			"example",
		],
		"Attributes": {
			"access": "Deny",
			"destination_port_range": ["22"],
			"protocol": "TCP",
			"source_address_prefix": "*",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ssh_access_not_restricted {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_network_security_rule",
			"example",
		],
		"Attributes": {
			"access": "Allow",
			"destination_port_range": ["22"],
			"protocol": "TCP",
			"source_address_prefix": "*",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
