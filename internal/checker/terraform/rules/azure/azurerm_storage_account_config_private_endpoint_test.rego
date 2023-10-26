package lib.terraform.CB_TFAZR_233

test_azurerm_storage_account_private_endpoint_set_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_private_endpoint",
				"example",
			],
			"Attributes": {
				"location": "East US",
				"name": "private-endpoint",
				"resource_group_name": "example-resources",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_storage_account",
				"example",
			],
			"Attributes": {
				"account_replication_type": "GRS",
				"account_tier": "Standard",
				"name": "examplestor",
				"resource_group_name": "azurerm_private_endpoint.example.resource_group_name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 7,
			},
		},
	]
	count(result) == 1
}

test_azurerm_storage_account_private_endpoint_set_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_private_endpoint",
				"example",
			],
			"Attributes": {
				"location": "East US",
				"name": "private-endpoint",
				"resource_group_name": "example-resources",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_storage_account",
				"example",
			],
			"Attributes": {
				"account_replication_type": "GRS",
				"account_tier": "Standard",
				"name": "examplestor",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 7,
			},
		},
	]
	count(result) == 1
}
