package lib.terraform.CB_TFAZR_137

test_azurerm_kubernetes_cluster_pooltype_is_scale_set_passed {
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
                        "type": "AvailabilitySet",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 18,
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
                        "endLine": 22,
                        "startLine": 20
                    }
                }
            ],
            "line_range": {
                "endLine": 27,
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
                "endLine": 32,
                "startLine": 29
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
                "endLine": 38,
                "startLine": 34
            }
        }
    ]
    count(result) == 1
}

test_azurerm_kubernetes_cluster_pooltype_is_scale_set_failed {
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
                        "max_pods": "50",
                        "name": "default",
                        "node_count": "1",
                        "type": "VirtualMachineScaleSets",
                        "vm_size": "Standard_D2_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 18,
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
                        "endLine": 22,
                        "startLine": 20
                    }
                }
            ],
            "line_range": {
                "endLine": 27,
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
                "endLine": 32,
                "startLine": 29
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
                "endLine": 38,
                "startLine": 34
            }
        }
    ]
    count(result) == 1
}