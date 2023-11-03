package lib.terraform.CB_TFAZR_014

test_azurerm_storage_container_trusted_microsoft_services_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_container",
			"example",
		],
		"Attributes": {"container_access_type": "private"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_storage_container_trusted_microsoft_services_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_container",
			"example",
		],
		"Attributes": {"container_access_type": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
