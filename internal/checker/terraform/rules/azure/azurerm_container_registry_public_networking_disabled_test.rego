package lib.terraform.CB_TFAZR_155

test_azurerm_container_registry_public_networking_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_container_registry"],
		"Attributes": {
			"location": "azurerm_resource_group.rg.location",
			"name": "containerRegistry1",
			"public_network_access_enabled": false,
			"resource_group_name": "azurerm_resource_group.rg.name",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_container_registry_public_networking_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_container_registry"],
		"Attributes": {
			"location": "azurerm_resource_group.rg.location",
			"name": "containerRegistry1",
			"public_network_access_enabled": true,
			"resource_group_name": "azurerm_resource_group.rg.name",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
