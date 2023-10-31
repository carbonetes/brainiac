package lib.terraform.CB_TFAZR_227

test_azurerm_kubernetes_cluster_azure_cni_enabled_passed {
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
                        "name": "default",
                        "node_count": "1",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 16,
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
                        "endLine": 20,
                        "startLine": 18
                    }
                },
                {
                    "Type": "network_profile",
                    "Labels": [],
                    "Attributes": {
                        "network_plugin": "Azure"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 28,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 29,
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
                "endLine": 34,
                "startLine": 31
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
                "endLine": 40,
                "startLine": 36
            }
        }
    ]
    count(result) == 1
}

test_azurerm_kubernetes_cluster_azure_cni_enabled_failed {
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
                        "name": "default",
                        "node_count": "1",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 16,
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
                        "endLine": 20,
                        "startLine": 18
                    }
                },
                {
                    "Type": "network_profile",
                    "Labels": [],
                    "Attributes": {
                        "network_plugin": "kubenet"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 28,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 29,
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
                "endLine": 34,
                "startLine": 31
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
                "endLine": 40,
                "startLine": 36
            }
        }
    ]
    count(result) == 1
}