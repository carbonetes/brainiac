package lib.terraform.CB_TFAZR_023

test_azurerm_postgresql_configuration_log_checkpoints_on {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_configuration",
			"example",
		],
		"Attributes": {
			"name": "log_checkpoints",
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

test_azurerm_postgresql_configuration_log_checkpoints_off {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_configuration",
			"example",
		],
		"Attributes": {
			"name": "log_checkpoints",
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
