package lib.terraform.CB_TFAZR_177

test_azurerm_kubernetes_cluster_no_public_ip {
	result := passed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_kubernetes_cluster"],
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
					"enable_node_public_ip": false,
					"name": "default",
					"node_count": "1",
					"vm_size": "Standard_D2_v2",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 7,
				},
			},
			{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 16,
					"startLine": 14,
				},
			},
		],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_kubernetes_cluster_has_public_ip {
	result := failed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_kubernetes_cluster"],
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
					"enable_node_public_ip": true,
					"name": "default",
					"node_count": "1",
					"vm_size": "Standard_D2_v2",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 7,
				},
			},
			{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 16,
					"startLine": 14,
				},
			},
		],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]

	count(result) == 1
}
