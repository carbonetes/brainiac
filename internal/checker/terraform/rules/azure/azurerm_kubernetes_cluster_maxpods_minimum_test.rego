package lib.terraform.CB_TFAZR_136

test_azurerm_kubernetes_cluster_maxpods_minimum_passed {
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
                        "max_pods": "50",
                        "name": "default",
                        "node_count": "1",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 17,
                        "startLine": 12
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
                        "endLine": 21,
                        "startLine": 19
                    }
                }
            ],
            "line_range": {
                "endLine": 26,
                "startLine": 6
            }
        },
        {
            "Type": "output",
            "Labels": [
                "client_certificate"
            ],
            "Attributes": {
                "sensitive": true,
                "value": "azurerm_kubernetes_cluster.example.kube_config..client_certificate"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 31,
                "startLine": 28
            }
        },
        {
            "Type": "output",
            "Labels": [
                "kube_config"
            ],
            "Attributes": {
                "sensitive": true,
                "value": "azurerm_kubernetes_cluster.example.kube_config_raw"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 37,
                "startLine": 33
            }
        }
    ]
    count(result) == 1
}

test_azurerm_kubernetes_cluster_maxpods_minimum_failed {
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
                        "max_pods": "49",
                        "name": "default",
                        "node_count": "1",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 17,
                        "startLine": 12
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
                        "endLine": 21,
                        "startLine": 19
                    }
                }
            ],
            "line_range": {
                "endLine": 26,
                "startLine": 6
            }
        },
        {
            "Type": "output",
            "Labels": [
                "client_certificate"
            ],
            "Attributes": {
                "sensitive": true,
                "value": "azurerm_kubernetes_cluster.example.kube_config..client_certificate"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 31,
                "startLine": 28
            }
        },
        {
            "Type": "output",
            "Labels": [
                "kube_config"
            ],
            "Attributes": {
                "sensitive": true,
                "value": "azurerm_kubernetes_cluster.example.kube_config_raw"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 37,
                "startLine": 33
            }
        }
    ]
    count(result) == 1
}
