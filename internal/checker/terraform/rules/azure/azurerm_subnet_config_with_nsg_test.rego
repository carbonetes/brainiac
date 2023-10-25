package lib.terraform.CB_TFAZR_229

test_azurerm_subnet_config_with_nsg_passed {
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
                    "10.0.1.0/24"
                ],
                "name": "example-subnet",
                "resource_group_name": "azurerm_resource_group.example.name",
                "virtual_network_name": "azurerm_virtual_network.example.name"
            },
            "Blocks": [
                {
                    "Type": "delegation",
                    "Labels": [],
                    "Attributes": {
                        "name": "delegation"
                    },
                    "Blocks": [
                        {
                            "Type": "service_delegation",
                            "Labels": [],
                            "Attributes": {
                                "actions": [
                                    "Microsoft.Network/virtualNetworks/subnets/join/action",
                                    "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
                                ],
                                "name": "Microsoft.ContainerInstance/containerGroups"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 25,
                                "startLine": 22
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 26,
                        "startLine": 19
                    }
                }
            ],
            "line_range": {
                "endLine": 27,
                "startLine": 13
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
                "name": "example-nsg",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "security_rule",
                    "Labels": [],
                    "Attributes": {
                        "access": "Allow",
                        "destination_address_prefix": "*",
                        "destination_port_range": "*",
                        "direction": "Inbound",
                        "name": "test123",
                        "priority": "100",
                        "protocol": "Tcp",
                        "source_address_prefix": "*",
                        "source_port_range": "*"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 44,
                        "startLine": 34
                    }
                }
            ],
            "line_range": {
                "endLine": 45,
                "startLine": 29
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_subnet_network_security_group_association",
                "example"
            ],
            "Attributes": {
                "network_security_group_id": "azurerm_network_security_group.example.id",
                "subnet_id": "azurerm_subnet.example.id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 50,
                "startLine": 47
            }
        }
    ]
    count(result) == 1
}

test_azurerm_subnet_config_with_nsg_failed {
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
                    "10.0.1.0/24"
                ],
                "name": "AzureFirewallSubnet",
                "resource_group_name": "azurerm_resource_group.example.name",
                "virtual_network_name": "azurerm_virtual_network.example.name"
            },
            "Blocks": [
                {
                    "Type": "delegation",
                    "Labels": [],
                    "Attributes": {
                        "name": "delegation"
                    },
                    "Blocks": [
                        {
                            "Type": "service_delegation",
                            "Labels": [],
                            "Attributes": {
                                "actions": [
                                    "Microsoft.Network/virtualNetworks/subnets/join/action",
                                    "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
                                ],
                                "name": "Microsoft.ContainerInstance/containerGroups"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 25,
                                "startLine": 22
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 26,
                        "startLine": 19
                    }
                }
            ],
            "line_range": {
                "endLine": 27,
                "startLine": 13
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
                "name": "example-nsg",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "security_rule",
                    "Labels": [],
                    "Attributes": {
                        "access": "Allow",
                        "destination_address_prefix": "*",
                        "destination_port_range": "*",
                        "direction": "Inbound",
                        "name": "test123",
                        "priority": "100",
                        "protocol": "Tcp",
                        "source_address_prefix": "*",
                        "source_port_range": "*"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 44,
                        "startLine": 34
                    }
                }
            ],
            "line_range": {
                "endLine": 45,
                "startLine": 29
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_subnet_network_security_group_association",
                "example"
            ],
            "Attributes": {
                "network_security_group_id": "azurerm_network_security_group.example.id",
                "subnet_id": "azurerm_subnet.example.id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 50,
                "startLine": 47
            }
        }
    ]
    count(result) == 1
}