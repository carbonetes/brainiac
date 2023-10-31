package lib.terraform.CB_TFAZR_142

test_azurerm_kubernetes_cluster_secret_store_rotation_passed {
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
                "automatic_channel_upgrade": "none",
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
                        "endLine": 20,
                        "startLine": 14
                    }
                },
                {
                    "Type": "key_vault_secrets_provider",
                    "Labels": [],
                    "Attributes": {
                        "secret_rotation_enabled": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 22
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
                        "endLine": 28,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 33,
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
                "endLine": 38,
                "startLine": 35
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
                "endLine": 44,
                "startLine": 40
            }
        }
    ]
    count(result) == 1
}

test_azurerm_kubernetes_cluster_secret_store_rotation_failed {
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
                "automatic_channel_upgrade": "none",
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
                        "endLine": 20,
                        "startLine": 14
                    }
                },
                {
                    "Type": "key_vault_secrets_provider",
                    "Labels": [],
                    "Attributes": {
                        "secret_rotation_enabled": false
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 22
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
                        "endLine": 28,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 33,
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
                "endLine": 38,
                "startLine": 35
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
                "endLine": 44,
                "startLine": 40
            }
        }
    ]
    count(result) == 1
}