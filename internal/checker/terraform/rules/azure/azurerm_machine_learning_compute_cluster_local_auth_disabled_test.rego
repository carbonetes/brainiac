package lib.terraform.CB_TFAZR_149

test_azurerm_machine_learning_compute_cluster_local_auth_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_machine_learning_compute_cluster"],
		"Attributes": {
			"local_auth_enabled": false,
			"location": "West Europe",
			"machine_learning_workspace_id": "azurerm_machine_learning_workspace.example.id",
			"name": "example",
			"vm_priority": "LowPriority",
			"vm_size": "Standard_DS2_v2",
		},
		"Blocks": [
			{
				"Type": "scale_settings",
				"Labels": [],
				"Attributes": {
					"max_node_count": "1",
					"min_node_count": "0",
					"scale_down_nodes_after_idle_duration": "PT30S",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 13,
					"startLine": 9,
				},
			},
			{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 17,
					"startLine": 15,
				},
			},
		],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_machine_learning_compute_cluster_local_auth_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_machine_learning_compute_cluster"],
		"Attributes": {
			"local_auth_enabled": true,
			"location": "West Europe",
			"machine_learning_workspace_id": "azurerm_machine_learning_workspace.example.id",
			"name": "example",
			"vm_priority": "LowPriority",
			"vm_size": "Standard_DS2_v2",
		},
		"Blocks": [
			{
				"Type": "scale_settings",
				"Labels": [],
				"Attributes": {
					"max_node_count": "1",
					"min_node_count": "0",
					"scale_down_nodes_after_idle_duration": "PT30S",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 13,
					"startLine": 9,
				},
			},
			{
				"Type": "identity",
				"Labels": [],
				"Attributes": {"type": "SystemAssigned"},
				"Blocks": [],
				"line_range": {
					"endLine": 17,
					"startLine": 15,
				},
			},
		],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
