package lib.terraform.CB_TFAZR_027

test_azurerm_storage_account_storage_logging_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"example",
		],
		"Attributes": {
			"account_replication_type": "GRS",
			"account_tier": "Standard",
			"location": "data.azurerm_resource_group.example.location",
			"name": "example",
			"resource_group_name": "data.azurerm_resource_group.example.name",
		},
		"Blocks": [{
			"Type": "queue_properties",
			"Labels": [],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "logging",
					"Labels": [],
					"Attributes": {
						"delete": true,
						"read": true,
						"retention_policy_days": "10",
						"version": "1.0",
						"write": true,
					},
					"Blocks": [],
					"line_range": {
						"endLine": 14,
						"startLine": 8,
					},
				},
				{
					"Type": "hour_metrics",
					"Labels": [],
					"Attributes": {
						"enabled": true,
						"include_apis": true,
						"retention_policy_days": "10",
						"version": "1.0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 20,
						"startLine": 15,
					},
				},
				{
					"Type": "minute_metrics",
					"Labels": [],
					"Attributes": {
						"enabled": true,
						"include_apis": true,
						"retention_policy_days": "10",
						"version": "1.0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 26,
						"startLine": 21,
					},
				},
			],
			"line_range": {
				"endLine": 27,
				"startLine": 7,
			},
		}],
		"line_range": {
			"endLine": 28,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_storage_account_storage_logging_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"example",
		],
		"Attributes": {
			"account_replication_type": "GRS",
			"account_tier": "Standard",
			"location": "data.azurerm_resource_group.example.location",
			"name": "example",
			"resource_group_name": "data.azurerm_resource_group.example.name",
		},
		"Blocks": [{
			"Type": "queue_properties",
			"Labels": [],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "logging",
					"Labels": [],
					"Attributes": {
						"delete": false,
						"read": false,
						"retention_policy_days": "10",
						"version": "1.0",
						"write": false,
					},
					"Blocks": [],
					"line_range": {
						"endLine": 14,
						"startLine": 8,
					},
				},
				{
					"Type": "hour_metrics",
					"Labels": [],
					"Attributes": {
						"enabled": true,
						"include_apis": true,
						"retention_policy_days": "10",
						"version": "1.0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 20,
						"startLine": 15,
					},
				},
				{
					"Type": "minute_metrics",
					"Labels": [],
					"Attributes": {
						"enabled": true,
						"include_apis": true,
						"retention_policy_days": "10",
						"version": "1.0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 26,
						"startLine": 21,
					},
				},
			],
			"line_range": {
				"endLine": 27,
				"startLine": 7,
			},
		}],
		"line_range": {
			"endLine": 28,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
