package lib.terraform.CB_TFAZR_158

test_azurerm_virtual_network_single_dns_server_passed {
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
                "azurerm_network_security_group",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-security-group",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 10,
                "startLine": 6
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
                "dns_servers": [
                    "10.0.0.4",
                    "10.0.0.5",
                    "10.0.0.6"
                ],
                "location": "azurerm_resource_group.example.location",
                "name": "example-network",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
            },
            "Blocks": [
                {
                    "Type": "subnet",
                    "Labels": [],
                    "Attributes": {
                        "address_prefix": "10.0.1.0/24",
                        "name": "subnet1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 22,
                        "startLine": 19
                    }
                },
                {
                    "Type": "subnet",
                    "Labels": [],
                    "Attributes": {
                        "address_prefix": "10.0.2.0/24",
                        "name": "subnet2",
                        "security_group": "azurerm_network_security_group.example.id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 28,
                        "startLine": 24
                    }
                }
            ],
            "line_range": {
                "endLine": 33,
                "startLine": 12
            }
        }
    ]
    count(result) == 1
}

test_azurerm_virtual_network_single_dns_server_failed {
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
                "azurerm_network_security_group",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-security-group",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 10,
                "startLine": 6
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
                "dns_servers": [
                    "10.0.0.4"
                ],
                "location": "azurerm_resource_group.example.location",
                "name": "example-network",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
            },
            "Blocks": [
                {
                    "Type": "subnet",
                    "Labels": [],
                    "Attributes": {
                        "address_prefix": "10.0.1.0/24",
                        "name": "subnet1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 22,
                        "startLine": 19
                    }
                },
                {
                    "Type": "subnet",
                    "Labels": [],
                    "Attributes": {
                        "address_prefix": "10.0.2.0/24",
                        "name": "subnet2",
                        "security_group": "azurerm_network_security_group.example.id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 28,
                        "startLine": 24
                    }
                }
            ],
            "line_range": {
                "endLine": 33,
                "startLine": 12
            }
        }
    ]
    count(result) == 1
}