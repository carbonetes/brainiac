package lib.terraform.CB_TFAZR_058

test_azurerm_app_service_http_logging_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {
			"app_service_plan_id": "azurerm_app_service_plan.example.id",
			"app_settings": {"SOME_KEY": "some-value"},
			"location": "azurerm_resource_group.example.location",
			"name": "example-app-service",
			"resource_group_name": "azurerm_resource_group.example.name",
		},
		"Blocks": [
			{
				"Type": "logs",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "http_logs",
					"Labels": [],
					"Attributes": {
						"retention_in_days": "4",
						"retention_in_mb": "10",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 8,
					},
				}],
				"line_range": {
					"endLine": 12,
					"startLine": 7,
				},
			},
			{
				"Type": "connection_string",
				"Labels": [],
				"Attributes": {
					"name": "Database",
					"type": "SQLServer",
					"value": "Server=some-server.mydomain.com;Integrated Security=SSPI",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 22,
					"startLine": 18,
				},
			},
		],
		"line_range": {
			"endLine": 23,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_app_service_http_logging_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {
			"app_service_plan_id": "azurerm_app_service_plan.example.id",
			"app_settings": {"SOME_KEY": "some-value"},
			"location": "azurerm_resource_group.example.location",
			"name": "example-app-service",
			"resource_group_name": "azurerm_resource_group.example.name",
		},
		"Blocks": [{
			"Type": "connection_string",
			"Labels": [],
			"Attributes": {
				"name": "Database",
				"type": "SQLServer",
				"value": "Server=some-server.mydomain.com;Integrated Security=SSPI",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 22,
				"startLine": 18,
			},
		}],
		"line_range": {
			"endLine": 23,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
