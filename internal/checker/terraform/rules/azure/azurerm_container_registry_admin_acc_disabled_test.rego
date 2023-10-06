package lib.terraform.CB_TFAZR_131

test_azurerm_container_registry_admin_acc_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_container_registry"],
		"Attributes": {
			"admin_enabled": false,
			"location": "azurerm_resource_group.rg.location",
			"name": "containerRegistry1",
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

test_azurerm_container_registry_admin_acc_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_container_registry"],
		"Attributes": {
			"admin_enabled": true,
			"location": "azurerm_resource_group.rg.location",
			"name": "containerRegistry1",
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
