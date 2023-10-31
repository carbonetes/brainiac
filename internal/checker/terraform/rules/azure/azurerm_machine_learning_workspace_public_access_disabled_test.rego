package lib.terraform.CB_TFAZR_163

test_azurerm_machine_learning_workspace_public_access_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_machine_learning_workspace"],
		"Attributes": {
			"application_insights_id": "azurerm_application_insights.example.id",
			"key_vault_id": "azurerm_key_vault.example.id",
			"location": "azurerm_resource_group.example.location",
			"name": "example-workspace",
			"public_network_access_enabled": false,
			"resource_group_name": "azurerm_resource_group.example.name",
			"storage_account_id": "azurerm_storage_account.example.id",
		},
		"Blocks": [
			{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 10,
				},
			},
			{
				"Type": "encryption",
				"Labels": [],
				"Attributes": {
					"key_id": "azurerm_key_vault_key.example.id",
					"key_vault_id": "azurerm_key_vault.example.id",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 17,
					"startLine": 14,
				},
			},
		],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_machine_learning_workspace_public_access_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_machine_learning_workspace"],
		"Attributes": {
			"application_insights_id": "azurerm_application_insights.example.id",
			"key_vault_id": "azurerm_key_vault.example.id",
			"location": "azurerm_resource_group.example.location",
			"name": "example-workspace",
			"public_network_access_enabled": true,
			"resource_group_name": "azurerm_resource_group.example.name",
			"storage_account_id": "azurerm_storage_account.example.id",
		},
		"Blocks": [
			{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 10,
				},
			},
			{
				"Type": "encryption",
				"Labels": [],
				"Attributes": {
					"key_id": "azurerm_key_vault_key.example.id",
					"key_vault_id": "azurerm_key_vault.example.id",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 17,
					"startLine": 14,
				},
			},
		],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]

	count(result) == 1
}
