package lib.terraform.CB_TFAZR_019

test_azure_scale_set_password_passed {
	result := passed with input as [{
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
            "location": "East US",
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
            "azurerm_linux_virtual_machine_scale_set",
            "example"
        ],
        "Attributes": {
            "admin_password": "your_admin_password",
            "admin_username": "your_admin_username",
            "disable_password_authentication": true,
            "instances": "2",
            "location": "azurerm_resource_group.example.location",
            "name": "example-vmss",
            "resource_group_name": "azurerm_resource_group.example.name",
            "sku": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Type": "admin_ssh_key",
                "Labels": [],
                "Attributes": {
                    "username": "your_admin_username"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 23,
                    "startLine": 20
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
                    "endLine": 28,
                    "startLine": 25
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "name": "example-nic",
                    "primary": true
                },
                "Blocks": [
                    {
                        "Type": "ip_configuration",
                        "Labels": [],
                        "Attributes": {
                            "load_balancer_backend_address_pool_ids": "azurerm_lb.example.backend_address_pool_ids.",
                            "load_balancer_inbound_nat_rules_ids": "azurerm_lb.example.inbound_nat_rules_ids.",
                            "name": "example-nic-ipconfig",
                            "subnet_id": "azurerm_subnet.example.id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 39,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 40,
                    "startLine": 30
                }
            }
        ],
        "line_range": {
            "endLine": 43,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_scale_set_password_failed {
	result := failed with input as [{
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
            "location": "East US",
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
            "azurerm_linux_virtual_machine_scale_set",
            "example"
        ],
        "Attributes": {
            "admin_password": "your_admin_password",
            "admin_username": "your_admin_username",
            "disable_password_authentication": false,
            "instances": "2",
            "location": "azurerm_resource_group.example.location",
            "name": "example-vmss",
            "resource_group_name": "azurerm_resource_group.example.name",
            "sku": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Type": "admin_ssh_key",
                "Labels": [],
                "Attributes": {
                    "username": "your_admin_username"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 23,
                    "startLine": 20
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
                    "endLine": 28,
                    "startLine": 25
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "name": "example-nic",
                    "primary": true
                },
                "Blocks": [
                    {
                        "Type": "ip_configuration",
                        "Labels": [],
                        "Attributes": {
                            "load_balancer_backend_address_pool_ids": "azurerm_lb.example.backend_address_pool_ids.",
                            "load_balancer_inbound_nat_rules_ids": "azurerm_lb.example.inbound_nat_rules_ids.",
                            "name": "example-nic-ipconfig",
                            "subnet_id": "azurerm_subnet.example.id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 39,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 40,
                    "startLine": 30
                }
            }
        ],
        "line_range": {
            "endLine": 43,
            "startLine": 10
        }
    }]
	count(result) == 1
}
