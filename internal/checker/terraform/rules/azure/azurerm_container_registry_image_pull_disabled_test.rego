package lib.terraform.CB_TFAZR_141

test_azurerm_container_registry_image_pull_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_container_registry",
		],
		"Attributes": {
			"anonymous_pull_enabled": false,
			"location": "azurerm_resource_group.rg.location",
			"name": "containerRegistry1",
			"resource_group_name": "azurerm_resource_group.rg.name",
			"sku": "Premium",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_container_registry_image_pull_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_container_registry"
		],
		"Attributes": {
			"anonymous_pull_enabled": true,
			"location": "azurerm_resource_group.rg.location",
			"name": "containerRegistry1",
			"resource_group_name": "azurerm_resource_group.rg.name",
			"sku": "Premium",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
