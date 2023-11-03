package lib.terraform.CB_TFAZR_157

test_azurerm_kusto_cluster_service_identity_passed {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "my-kusto-cluster-rg"
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
                "azurerm_kusto_cluster",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "kustocluster",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "Environment": "Production"
                }
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "capacity": "2",
                        "name": "Standard_D13_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 11
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
                "endLine": 23,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_kusto_cluster_service_identity_failed {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "my-kusto-cluster-rg"
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
                "azurerm_kusto_cluster",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "kustocluster",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "Environment": "Production"
                }
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "capacity": "2",
                        "name": "Standard_D13_v2"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 11
                    }
                }
            ],
            "line_range": {
                "endLine": 23,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}