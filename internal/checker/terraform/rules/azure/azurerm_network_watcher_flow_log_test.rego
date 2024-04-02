package lib.terraform.CB_TFAZR_032

azurerm_network_watcher_flow_log_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_network_watcher_flow_log",
				"test"
			],
			"Attributes": {
				"enabled": true,
				"name": "example-log",
				"network_security_group_id": "azurerm_network_security_group.test.id",
				"network_watcher_name": "azurerm_network_watcher.test.name",
				"resource_group_name": "azurerm_resource_group.example.name",
				"storage_account_id": "azurerm_storage_account.test.id"
			},
			"Blocks": [
				{
					"Type": "retention_policy",
					"Labels": [],
					"Attributes": {
						"days": "7",
						"enabled": true
					},
					"Blocks": [],
					"line_range": {
						"endLine": 48,
						"startLine": 45
					}
				},
				{
					"Type": "traffic_analytics",
					"Labels": [],
					"Attributes": {
						"enabled": true,
						"interval_in_minutes": "10",
						"workspace_id": "azurerm_log_analytics_workspace.test.workspace_id",
						"workspace_region": "azurerm_log_analytics_workspace.test.location",
						"workspace_resource_id": "azurerm_log_analytics_workspace.test.id"
					},
					"Blocks": [],
					"line_range": {
						"endLine": 56,
						"startLine": 50
					}
				}
			],
			"line_range": {
				"endLine": 57,
				"startLine": 36
			}
		}
	]
}


azurerm_network_watcher_flow_log_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_network_watcher_flow_log",
				"test"
			],
			"Attributes": {
				"enabled": true,
				"name": "example-log",
				"network_security_group_id": "azurerm_network_security_group.test.id",
				"network_watcher_name": "azurerm_network_watcher.test.name",
				"resource_group_name": "azurerm_resource_group.example.name",
				"storage_account_id": "azurerm_storage_account.test.id"
			},
			"Blocks": [
				{
					"Type": "retention_policy",
					"Labels": [],
					"Attributes": {
						"days": "91",
						"enabled": false
					},
					"Blocks": [],
					"line_range": {
						"endLine": 48,
						"startLine": 45
					}
				},
				{
					"Type": "traffic_analytics",
					"Labels": [],
					"Attributes": {
						"enabled": true,
						"interval_in_minutes": "10",
						"workspace_id": "azurerm_log_analytics_workspace.test.workspace_id",
						"workspace_region": "azurerm_log_analytics_workspace.test.location",
						"workspace_resource_id": "azurerm_log_analytics_workspace.test.id"
					},
					"Blocks": [],
					"line_range": {
						"endLine": 56,
						"startLine": 50
					}
				}
			],
			"line_range": {
				"endLine": 57,
				"startLine": 36
			}
		}
	]
}

