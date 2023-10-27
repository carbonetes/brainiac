package lib.terraform.CB_TFAZR_230

test_azurerm_monitor_activity_log_alert_public_restricted_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_storage_container",
				"ok_container",
			],
			"Attributes": {
				"container_access_type": "private",
				"name": "vhds",
				"storage_account_name": "azurerm_storage_account.ok_account.name",
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
				"ok_account",
			],
			"Attributes": {
				"account_replication_type": "GRS",
				"account_tier": "Standard",
				"location": "azurerm_resource_group.main.location",
				"name": "examplesa",
				"resource_group_name": "azurerm_resource_group.main.name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 7,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_monitor_activity_log_alert",
				"ok_monitor_activity_log_alert",
			],
			"Attributes": {
				"description": "This alert will monitor a specific storage account updates.",
				"name": "example-activitylogalert",
				"resource_group_name": "azurerm_resource_group.main.name",
				"scopes": "azurerm_resource_group.main.id",
			},
			"Blocks": [
				{
					"Type": "criteria",
					"Labels": [],
					"Attributes": {
						"category": "Recommendation",
						"operation_name": "Microsoft.Storage/storageAccounts/write",
						"resource_id": "azurerm_storage_account.ok_account.id",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 25,
						"startLine": 21,
					},
				},
				{
					"Type": "action",
					"Labels": [],
					"Attributes": {
						"action_group_id": "azurerm_monitor_action_group.main.id",
						"webhook_properties": {"from": "terraform"},
					},
					"Blocks": [],
					"line_range": {
						"endLine": 34,
						"startLine": 28,
					},
				},
			],
			"line_range": {
				"endLine": 35,
				"startLine": 15,
			},
		},
	]
	count(result) == 1
}

test_azurerm_monitor_activity_log_alert_public_restricted_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_storage_container",
				"ok_container",
			],
			"Attributes": {
				"container_access_type": "public",
				"name": "vhds",
				"storage_account_name": "azurerm_storage_account.ok_account.name",
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
				"ok_account",
			],
			"Attributes": {
				"account_replication_type": "GRS",
				"account_tier": "Standard",
				"location": "azurerm_resource_group.main.location",
				"name": "examplesa",
				"resource_group_name": "azurerm_resource_group.main.name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 7,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_monitor_activity_log_alert",
				"ok_monitor_activity_log_alert",
			],
			"Attributes": {
				"description": "This alert will monitor a specific storage account updates.",
				"name": "example-activitylogalert",
				"resource_group_name": "azurerm_resource_group.main.name",
				"scopes": "azurerm_resource_group.main.id",
			},
			"Blocks": [
				{
					"Type": "criteria",
					"Labels": [],
					"Attributes": {
						"category": "Recommendation",
						"operation_name": "Microsoft.Storage/storageAccounts/write",
						"resource_id": "azurerm_storage_account.ok_account.id",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 25,
						"startLine": 21,
					},
				},
				{
					"Type": "action",
					"Labels": [],
					"Attributes": {
						"action_group_id": "azurerm_monitor_action_group.main.id",
						"webhook_properties": {"from": "terraform"},
					},
					"Blocks": [],
					"line_range": {
						"endLine": 34,
						"startLine": 28,
					},
				},
			],
			"line_range": {
				"endLine": 35,
				"startLine": 15,
			},
		},
	]
	count(result) == 1
}
