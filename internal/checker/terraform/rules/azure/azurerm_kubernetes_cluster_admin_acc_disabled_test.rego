package lib.terraform.CB_TFAZR_150

test_azurerm_kubernetes_cluster_admin_acc_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_kubernetes_cluster"],
		"Attributes": {
			"local_account_disabled": true,
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
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 15,
					"startLine": 13,
				},
			},
		],
		"line_range": {
			"endLine": 20,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_kubernetes_cluster_admin_acc_disabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_kubernetes_cluster"],
		"Attributes": {
			"local_account_disabled": false,
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
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 15,
					"startLine": 13,
				},
			},
		],
		"line_range": {
			"endLine": 20,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
