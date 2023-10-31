package lib.terraform.CB_TFAZR_140

test_azure_ml_compute_cluster_min_nodes_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "azurerm"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "features",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_machine_learning_compute_cluster"
        ],
        "Attributes": {
            "location": "West Europe",
            "machine_learning_workspace_id": "azurerm_machine_learning_workspace.example.id",
            "name": "example",
            "subnet_resource_id": "azurerm_subnet.example.id",
            "vm_priority": "LowPriority",
            "vm_size": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Type": "scale_settings",
                "Labels": [],
                "Attributes": {
                    "max_node_count": "1",
                    "min_node_count": "0",
                    "scale_down_nodes_after_idle_duration": "PT30S"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_ml_compute_cluster_min_nodes_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "azurerm"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "features",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_machine_learning_compute_cluster",

        ],
        "Attributes": {
            "location": "West Europe",
            "machine_learning_workspace_id": "azurerm_machine_learning_workspace.example.id",
            "name": "example",
            "subnet_resource_id": "azurerm_subnet.example.id",
            "vm_priority": "LowPriority",
            "vm_size": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Type": "scale_settings",
                "Labels": [],
                "Attributes": {
                    "max_node_count": "1",
                    "min_node_count": "1",
                    "scale_down_nodes_after_idle_duration": "PT30S"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 5
        }
    }]
	count(result) == 1
}