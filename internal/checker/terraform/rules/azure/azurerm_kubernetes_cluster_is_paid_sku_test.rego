package lib.terraform.CB_TFAZR_138

test_azurerm_kubernetes_cluster_is_paid_sku_passed {
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
                "sku_tier": "Standard",
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
                        "type": "AvailabilitySet",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 13
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
                        "endLine": 23,
                        "startLine": 21
                    }
                }
            ],
            "line_range": {
                "endLine": 28,
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
                "endLine": 33,
                "startLine": 30
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
                "endLine": 39,
                "startLine": 35
            }
        }
    ]
    count(result) == 1
}

test_azurerm_kubernetes_cluster_is_paid_sku_failed {
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
                "sku_tier": "Free",
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
                        "type": "AvailabilitySet",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 13
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
                        "endLine": 23,
                        "startLine": 21
                    }
                }
            ],
            "line_range": {
                "endLine": 28,
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
                "endLine": 33,
                "startLine": 30
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
                "endLine": 39,
                "startLine": 35
            }
        }
    ]
    count(result) == 1
}