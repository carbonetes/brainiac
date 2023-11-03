package lib.terraform.CB_TFAZR_147

test_azurerm_windows_virtual_machine_automatic_updates_passed {
	result := passed with input as [
        {
            "Type": "provider",
            "Labels": [
                "azurerm"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "features",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [],
                    "line_range": {
                        "endLine": 2,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 3,
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
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 8,
                "startLine": 5
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
                "endLine": 15,
                "startLine": 10
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
                "endLine": 22,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_network_interface",
                "example"
            ],
            "Attributes": {
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
                        "endLine": 33,
                        "startLine": 29
                    }
                }
            ],
            "line_range": {
                "endLine": 34,
                "startLine": 24
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_windows_virtual_machine",
                "example"
            ],
            "Attributes": {
                "admin_password": "P@$$w0rd1234!",
                "admin_username": "adminuser",
                "enable_automatic_updates": true,
                "location": "azurerm_resource_group.example.location",
                "name": "example-machine",
                "network_interface_ids": "azurerm_network_interface.example.id",
                "resource_group_name": "azurerm_resource_group.example.name",
                "size": "Standard_F2"
            },
            "Blocks": [
                {
                    "Type": "os_disk",
                    "Labels": [],
                    "Attributes": {
                        "caching": "ReadWrite",
                        "storage_account_type": "Standard_LRS"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 51,
                        "startLine": 48
                    }
                },
                {
                    "Type": "source_image_reference",
                    "Labels": [],
                    "Attributes": {
                        "offer": "WindowsServer",
                        "publisher": "MicrosoftWindowsServer",
                        "sku": "2016-Datacenter",
                        "version": "latest"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 58,
                        "startLine": 53
                    }
                }
            ],
            "line_range": {
                "endLine": 59,
                "startLine": 36
            }
        }
    ]
    count(result)== 1
}

test_azurerm_windows_virtual_machine_automatic_updates_failed {
	result := failed with input as [
        {
            "Type": "provider",
            "Labels": [
                "azurerm"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "features",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [],
                    "line_range": {
                        "endLine": 2,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 3,
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
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 8,
                "startLine": 5
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
                "endLine": 15,
                "startLine": 10
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
                "endLine": 22,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_network_interface",
                "example"
            ],
            "Attributes": {
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
                        "endLine": 33,
                        "startLine": 29
                    }
                }
            ],
            "line_range": {
                "endLine": 34,
                "startLine": 24
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_windows_virtual_machine",
                "example"
            ],
            "Attributes": {
                "admin_password": "P@$$w0rd1234!",
                "admin_username": "adminuser",
                "enable_automatic_updates": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example-machine",
                "network_interface_ids": "azurerm_network_interface.example.id",
                "resource_group_name": "azurerm_resource_group.example.name",
                "size": "Standard_F2"
            },
            "Blocks": [
                {
                    "Type": "os_disk",
                    "Labels": [],
                    "Attributes": {
                        "caching": "ReadWrite",
                        "storage_account_type": "Standard_LRS"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 51,
                        "startLine": 48
                    }
                },
                {
                    "Type": "source_image_reference",
                    "Labels": [],
                    "Attributes": {
                        "offer": "WindowsServer",
                        "publisher": "MicrosoftWindowsServer",
                        "sku": "2016-Datacenter",
                        "version": "latest"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 58,
                        "startLine": 53
                    }
                }
            ],
            "line_range": {
                "endLine": 59,
                "startLine": 36
            }
        }
    ]
    count(result)== 1
}