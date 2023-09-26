package lib.terraform.CB_TFAZR_051

test_sks_logging_to_azr_configured {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"example",
		],
		"Attributes": {
			"dns_prefix": "exampleaks1",
			"location": "azurerm_resource_group.example.location",
			"name": "example-aks1",
			"resource_group_name": "azurerm_resource_group.example.name",
			"tags": {"Environment": "Production"},
		},
		"Blocks": [
			{
				"Type": "default_node_pool",
				"Labels": [],
				"Attributes": {
					"name": "default",
					"node_count": "1",
					"vm_size": "Standard_D2_v2",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 11,
					"startLine": 7,
				},
			},
			{
				"Type": "addon_profile",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "oms_agent",
					"Labels": [],
					"Attributes": {
						"enabled": true,
						"log_analytics_workspace_id": "workspaceResourceId",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 14,
					},
				}],
				"line_range": {
					"endLine": 18,
					"startLine": 13,
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

test_sks_logging_to_azr_not_configured {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"example",
		],
		"Attributes": {
			"dns_prefix": "exampleaks1",
			"location": "azurerm_resource_group.example.location",
			"name": "example-aks1",
			"resource_group_name": "azurerm_resource_group.example.name",
			"tags": {"Environment": "Production"},
		},
		"Blocks": [
			{
				"Type": "default_node_pool",
				"Labels": [],
				"Attributes": {
					"name": "default",
					"node_count": "1",
					"vm_size": "Standard_D2_v2",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 11,
					"startLine": 7,
				},
			},
			{
				"Type": "addon_profile",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "oms_agent",
					"Labels": [],
					"Attributes": {
						"enabled": false,
						"log_analytics_workspace_id": "workspaceResourceId",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 14,
					},
				}],
				"line_range": {
					"endLine": 18,
					"startLine": 13,
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
