package lib.terraform.CB_TFAZR_233

test_azurerm_storage_account_config_private_endpoint_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "LRS",
                "account_tier": "Standard",
                "location": "East US",
                "name": "mystorageaccount",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 7,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "East US",
                "name": "my-resource-group"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 9
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_private_endpoint",
                "example"
            ],
            "Attributes": {
                "name": "example",
                "subnet_id": "azurerm_subnet.example.id"
            },
            "Blocks": [
                {
                    "Type": "private_service_connection",
                    "Labels": [],
                    "Attributes": {
                        "name": "example-connection",
                        "private_connection_resource_id": "azurerm_storage_account.example.id",
                        "subresource_names": [
                            "blob"
                        ]
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 20,
                        "startLine": 16
                    }
                },
                {
                    "Type": "private_dns_zone_group",
                    "Labels": [],
                    "Attributes": {
                        "name": "example-group",
                        "private_dns_zone_ids": "azurerm_private_dns_zone.example.id",
                        "private_dns_zone_name": "azurerm_private_dns_zone.example.name",
                        "private_dns_zone_type": "Private"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 22
                    }
                }
            ],
            "line_range": {
                "endLine": 28,
                "startLine": 14
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_subnet",
                "example"
            ],
            "Attributes": {
                "address_prefixes": [
                    "10.0.1.0/24"
                ],
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name",
                "virtual_network_name": "azurerm_virtual_network.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 35,
                "startLine": 30
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_virtual_network",
                "example"
            ],
            "Attributes": {
                "address_space": [
                    "10.0.0.0/16"
                ],
                "location": "azurerm_resource_group.example.location",
                "name": "example-network",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 42,
                "startLine": 37
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_private_dns_zone",
                "example"
            ],
            "Attributes": {
                "name": "example.privatelink.blob.core.windows.net",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 47,
                "startLine": 44
            }
        }
    ]
    count(result) == 1
}

test_azurerm_storage_account_config_private_endpoint_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "LRS",
                "account_tier": "Standard",
                "location": "East US",
                "name": "mystorageaccount",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 7,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "East US",
                "name": "my-resource-group"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 9
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_subnet",
                "example"
            ],
            "Attributes": {
                "address_prefixes": [
                    "10.0.1.0/24"
                ],
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name",
                "virtual_network_name": "azurerm_virtual_network.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 35,
                "startLine": 30
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_virtual_network",
                "example"
            ],
            "Attributes": {
                "address_space": [
                    "10.0.0.0/16"
                ],
                "location": "azurerm_resource_group.example.location",
                "name": "example-network",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 42,
                "startLine": 37
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_private_dns_zone",
                "example"
            ],
            "Attributes": {
                "name": "example.privatelink.blob.core.windows.net",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 47,
                "startLine": 44
            }
        }
    ]
    count(result) == 1
}