package lib.terraform.CB_TFAZR_223

test_azurerm_kusto_cluster_encryption_cmk_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_kusto_cluster",
				"cluster_ok",
			],
			"Attributes": {
				"location": "azurerm_resource_group.rg.location",
				"name": "kustocluster",
				"resource_group_name": "azurerm_resource_group.rg.name",
			},
			"Blocks": [
				{
					"Type": "sku",
					"Labels": [],
					"Attributes": {
						"capacity": "2",
						"name": "Standard_D13_v2",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 9,
						"startLine": 6,
					},
				},
				{
					"Type": "identity",
					"Labels": [],
					"Attributes": {"type": "SystemAssigned"},
					"Blocks": [],
					"line_range": {
						"endLine": 13,
						"startLine": 11,
					},
				},
			],
			"line_range": {
				"endLine": 14,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_kusto_cluster_customer_managed_key",
				"example",
			],
			"Attributes": {
				"cluster_id": "azurerm_kusto_cluster.cluster_ok.id",
				"key_name": "azurerm_key_vault_key.example.name",
				"key_vault_id": "azurerm_key_vault.example.id",
				"key_version": "azurerm_key_vault_key.example.version",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 21,
				"startLine": 16,
			},
		},
	]
	count(result) == 1
}

test_azurerm_kusto_cluster_encryption_cmk_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_kusto_cluster",
				"cluster_ok",
			],
			"Attributes": {
				"location": "azurerm_resource_group.rg.location",
				"name": "kustocluster",
				"resource_group_name": "azurerm_resource_group.rg.name",
			},
			"Blocks": [
				{
					"Type": "sku",
					"Labels": [],
					"Attributes": {
						"capacity": "2",
						"name": "Standard_D13_v2",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 9,
						"startLine": 6,
					},
				},
				{
					"Type": "identity",
					"Labels": [],
					"Attributes": {"type": "SystemAssigned"},
					"Blocks": [],
					"line_range": {
						"endLine": 13,
						"startLine": 11,
					},
				},
			],
			"line_range": {
				"endLine": 14,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_kusto_cluster_customer_managed_key",
				"example",
			],
			"Attributes": {
				"key_name": "azurerm_key_vault_key.example.name",
				"key_vault_id": "azurerm_key_vault.example.id",
				"key_version": "azurerm_key_vault_key.example.version",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 21,
				"startLine": 16,
			},
		},
	]
	count(result) == 1
}
