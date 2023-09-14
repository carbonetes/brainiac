package lib.terraform.CB_TFAZR_025

test_azurerm_postgresql_configuration_connection_throttling_set_on {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_configuration",
			"example",
		],
		"Attributes": {
			"name": "connection_throttling",
			"resource_group_name": "data.azurerm_resource_group.example.name",
			"server_name": "azurerm_postgresql_server.example.name",
			"value": "on",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_postgresql_configuration_connection_throttling_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_configuration",
			"example",
		],
		"Attributes": {
			"name": "connection_throttling",
			"resource_group_name": "data.azurerm_resource_group.example.name",
			"server_name": "azurerm_postgresql_server.example.name",
			"value": "off",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
