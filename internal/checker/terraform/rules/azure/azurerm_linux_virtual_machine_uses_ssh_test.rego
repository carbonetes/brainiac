package lib.terraform.CB_TFAZR_152

test_azurerm_linux_virtual_machine_uses_ssh_passed {
    result := passed with input as [
        {
            "Type": "locals",
            "Labels": [],
            "Attributes": {
                "first_public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wWK73dCr+jgQOAxNsHAnNNNMEMWOHYEccp6wJm2gotpr9katuF/ZAdou5AaW1C61slRkHRkpRRX9FA9CYBiitZgvCCz+3nWNN7l/Up54Zps/pHWGZLHNJZRYyAB6j5yVLMVHIHriY49d/GZTZVNB8GoJv9Gakwc/fuEZYYl4YDFiGMBP///TzlI4jhiJzjKnEvqPFki5p2ZRJqcbCiF4pJrxUQR/RXqVFQdbRLZgYfJ8xGB878RENq3yQ39d8dVOkq4edbkzwcUmwwwkYVPIoDGsYLaRHnG+To7FvMeyO7xDVQkMKzopTQV8AuKpyvpqu0a9pWOMaiCyDytO7GGN you@me.com"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 3,
                "startLine": 1
            }
        },
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
                        "endLine": 6,
                        "startLine": 6
                    }
                }
            ],
            "line_range": {
                "endLine": 7,
                "startLine": 5
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
                "endLine": 12,
                "startLine": 9
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
                "endLine": 19,
                "startLine": 14
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_subnet",
                "internal"
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
                "endLine": 26,
                "startLine": 21
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_linux_virtual_machine_scale_set",
                "example"
            ],
            "Attributes": {
                "admin_username": "adminuser",
                "instances": "1",
                "location": "azurerm_resource_group.example.location",
                "name": "example-vmss",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard_F2"
            },
            "Blocks": [
                {
                    "Type": "admin_ssh_key",
                    "Labels": [],
                    "Attributes": {
                        "public_key": "local.first_public_key",
                        "username": "adminuser"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 39,
                        "startLine": 36
                    }
                },
                {
                    "Type": "source_image_reference",
                    "Labels": [],
                    "Attributes": {
                        "offer": "0001-com-ubuntu-server-focal",
                        "publisher": "Canonical",
                        "sku": "20_04-lts",
                        "version": "latest"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 46,
                        "startLine": 41
                    }
                },
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
                    "Type": "network_interface",
                    "Labels": [],
                    "Attributes": {
                        "name": "example",
                        "primary": true
                    },
                    "Blocks": [
                        {
                            "Type": "ip_configuration",
                            "Labels": [],
                            "Attributes": {
                                "name": "internal",
                                "primary": true,
                                "subnet_id": "azurerm_subnet.internal.id"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 61,
                                "startLine": 57
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 62,
                        "startLine": 53
                    }
                }
            ],
            "line_range": {
                "endLine": 63,
                "startLine": 28
            }
        }
    ]
    count(result) == 1
}

test_azurerm_linux_virtual_machine_uses_ssh_failed {
    result := failed with input as [
        {
            "Type": "locals",
            "Labels": [],
            "Attributes": {
                "first_public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wWK73dCr+jgQOAxNsHAnNNNMEMWOHYEccp6wJm2gotpr9katuF/ZAdou5AaW1C61slRkHRkpRRX9FA9CYBiitZgvCCz+3nWNN7l/Up54Zps/pHWGZLHNJZRYyAB6j5yVLMVHIHriY49d/GZTZVNB8GoJv9Gakwc/fuEZYYl4YDFiGMBP///TzlI4jhiJzjKnEvqPFki5p2ZRJqcbCiF4pJrxUQR/RXqVFQdbRLZgYfJ8xGB878RENq3yQ39d8dVOkq4edbkzwcUmwwwkYVPIoDGsYLaRHnG+To7FvMeyO7xDVQkMKzopTQV8AuKpyvpqu0a9pWOMaiCyDytO7GGN you@me.com"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 3,
                "startLine": 1
            }
        },
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
                        "endLine": 6,
                        "startLine": 6
                    }
                }
            ],
            "line_range": {
                "endLine": 7,
                "startLine": 5
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
                "endLine": 12,
                "startLine": 9
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
                "endLine": 19,
                "startLine": 14
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_subnet",
                "internal"
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
                "endLine": 26,
                "startLine": 21
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_linux_virtual_machine_scale_set",
                "example"
            ],
            "Attributes": {
                "admin_username": "adminuser",
                "instances": "1",
                "location": "azurerm_resource_group.example.location",
                "name": "example-vmss",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard_F2"
            },
            "Blocks": [
                {
                    "Type": "source_image_reference",
                    "Labels": [],
                    "Attributes": {
                        "offer": "0001-com-ubuntu-server-focal",
                        "publisher": "Canonical",
                        "sku": "20_04-lts",
                        "version": "latest"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 46,
                        "startLine": 41
                    }
                },
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
                    "Type": "network_interface",
                    "Labels": [],
                    "Attributes": {
                        "name": "example",
                        "primary": true
                    },
                    "Blocks": [
                        {
                            "Type": "ip_configuration",
                            "Labels": [],
                            "Attributes": {
                                "name": "internal",
                                "primary": true,
                                "subnet_id": "azurerm_subnet.internal.id"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 61,
                                "startLine": 57
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 62,
                        "startLine": 53
                    }
                }
            ],
            "line_range": {
                "endLine": 63,
                "startLine": 28
            }
        }
    ]
    count(result) == 1
}