package lib.terraform.CB_TFAZR_202

test_azurerm_storage_account_critical_data_encrypted {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": ["azurerm_storage_account"],
			"Attributes": {
				"account_replication_type": "GRS",
				"account_tier": "Standard",
				"location": "azurerm_resource_group.example.location",
				"name": "examplestor",
				"resource_group_name": "azurerm_resource_group.example.name",
			},
			"Blocks": [{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": ["azurerm_storage_account_customer_managed_key"],
			"Attributes": {
				"key_name": "azurerm_key_vault_key.example.name",
				"key_vault_id": "azurerm_key_vault.example.id",
				"storage_account_id": "azurerm_storage_account.ok_storage_account.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 18,
				"startLine": 14,
			},
		},
	]
	count(result) == 1
}

test_azurerm_storage_account_critical_data_not_encrypted {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": ["azurerm_storage_account"],
			"Attributes": {
				"account_replication_type": "GRS",
				"account_tier": "Standard",
				"location": "azurerm_resource_group.example.location",
				"name": "examplestor",
				"resource_group_name": "azurerm_resource_group.example.name",
			},
			"Blocks": [{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": ["azurerm_storage_account_customer_managed_key"],
			"Attributes": {
				"key_name": "azurerm_key_vault_key.example.name",
				"key_vault_id": "azurerm_key_vault.example.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 18,
				"startLine": 14,
			},
		},
	]
	count(result) == 1
}
