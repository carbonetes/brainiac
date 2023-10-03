package lib.terraform.CB_TFAZR_121

test_azurerm_network_interface_enable_ip_forwarding_passed {
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
                "endLine": 11,
                "startLine": 6
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
                    "10.0.2.0/24"
                ],
                "name": "internal",
                "resource_group_name": "azurerm_resource_group.example.name",
                "virtual_network_name": "azurerm_virtual_network.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 18,
                "startLine": 13
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_network_interface",
                "example"
            ],
            "Attributes": {
                "enable_ip_forwarding": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example-nic",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "ip_configuration",
                    "Labels": [],
                    "Attributes": {
                        "name": "internal",
                        "private_ip_address_allocation": "Dynamic",
                        "subnet_id": "azurerm_subnet.example.id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 30,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 31,
                "startLine": 20
            }
        }
    ]
	count(result) == 1
}

test_azurerm_network_interface_enable_ip_forwarding_failed {
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
                "endLine": 11,
                "startLine": 6
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
                    "10.0.2.0/24"
                ],
                "name": "internal",
                "resource_group_name": "azurerm_resource_group.example.name",
                "virtual_network_name": "azurerm_virtual_network.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 18,
                "startLine": 13
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_network_interface",
                "example"
            ],
            "Attributes": {
                "enable_ip_forwarding": true,
                "location": "azurerm_resource_group.example.location",
                "name": "example-nic",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "ip_configuration",
                    "Labels": [],
                    "Attributes": {
                        "name": "internal",
                        "private_ip_address_allocation": "Dynamic",
                        "subnet_id": "azurerm_subnet.example.id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 30,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 31,
                "startLine": 20
            }
        }
    ]
	count(result) == 1
}
