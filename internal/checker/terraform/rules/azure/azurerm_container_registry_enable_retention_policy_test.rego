package lib.terraform.CB_TFAZR_135

test_azurerm_container_registry_enable_retention_policy_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_container_registry",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "containerRegistry1",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Premium"
            },
            "Blocks": [
                {
                    "Type": "retention_policy",
                    "Labels": [],
                    "Attributes": {
                        "enabled": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 12
                    }
                }
            ],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_kubernetes_cluster",
                "example"
            ],
            "Attributes": {
                "dns_prefix": "exampleaks1",
                "location": "azurerm_resource_group.example.location",
                "name": "example-aks1",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "Environment": "Production"
                }
            },
            "Blocks": [
                {
                    "Type": "default_node_pool",
                    "Labels": [],
                    "Attributes": {
                        "name": "default",
                        "node_count": "1",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 23
                    }
                },
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "SystemAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 29
                    }
                }
            ],
            "line_range": {
                "endLine": 36,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_role_assignment",
                "example"
            ],
            "Attributes": {
                "principal_id": "azurerm_kubernetes_cluster.example.kubelet_identity..object_id",
                "role_definition_name": "AcrPull",
                "scope": "azurerm_container_registry.example.id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 42,
                "startLine": 38
            }
        }
    ]

    count(result) == 1
}

test_azurerm_container_registry_enable_retention_policy_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_container_registry",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "containerRegistry1",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Premium"
            },
            "Blocks": [
                {
                    "Type": "retention_policy",
                    "Labels": [],
                    "Attributes": {
                        "enabled": false
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 12
                    }
                }
            ],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_kubernetes_cluster",
                "example"
            ],
            "Attributes": {
                "dns_prefix": "exampleaks1",
                "location": "azurerm_resource_group.example.location",
                "name": "example-aks1",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "Environment": "Production"
                }
            },
            "Blocks": [
                {
                    "Type": "default_node_pool",
                    "Labels": [],
                    "Attributes": {
                        "name": "default",
                        "node_count": "1",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 23
                    }
                },
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "SystemAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 29
                    }
                }
            ],
            "line_range": {
                "endLine": 36,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_role_assignment",
                "example"
            ],
            "Attributes": {
                "principal_id": "azurerm_kubernetes_cluster.example.kubelet_identity..object_id",
                "role_definition_name": "AcrPull",
                "scope": "azurerm_container_registry.example.id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 42,
                "startLine": 38
            }
        }
    ]

    count(result) == 1
}
