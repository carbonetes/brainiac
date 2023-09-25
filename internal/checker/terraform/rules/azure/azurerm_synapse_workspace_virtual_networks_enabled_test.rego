package lib.terraform.CB_TFAZR_053

test_azurerm_synapse_workspace_virtual_networks_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_synapse_workspace",
			"example",
		],
		"Attributes": {"managed_virtual_network_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_synapse_workspace_virtual_networks_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_synapse_workspace",
			"example",
		],
		"Attributes": {"managed_virtual_network_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
