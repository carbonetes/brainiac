package lib.terraform.CB_TFAZR_013

test_azure_vm_creds_in_custom_data_passed {
	result := passed with input as [{
        "Attributes": {},
        "Blocks": [
            {
                "Attributes": {},
                "Blocks": [],
                "Labels": [],
                "Type": "features",
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "Labels": [
            "azurerm"
        ],
        "Type": "provider",
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "location": "East US",
            "name": "example-resources"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_resource_group",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Attributes": {
            "address_space": [
                "10.0.0.0/16"
            ],
            "location": "azurerm_resource_group.example.location",
            "name": "example-network",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_virtual_network",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 15,
            "startLine": 10
        }
    },
    {
        "Attributes": {
            "location": "azurerm_resource_group.example.location",
            "name": "var.prefix",
            "network_interface_ids": "azurerm_network_interface.example.id",
            "resource_group_name": "azurerm_resource_group.example.name",
            "vm_size": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Attributes": {
                    "offer": "UbuntuServer",
                    "publisher": "Canonical",
                    "sku": "16.04-LTS",
                    "version": "latest"
                },
                "Blocks": [],
                "Labels": [],
                "Type": "storage_image_reference",
                "line_range": {
                    "endLine": 29,
                    "startLine": 24
                }
            },
            {
                "Attributes": {
                    "admin_username": "adminuser",
                    "computer_name": "hostname"
                },
                "Blocks": [],
                "Labels": [],
                "Type": "os_profile",
                "line_range": {
                    "endLine": 42,
                    "startLine": 31
                }
            },
            {
                "Attributes": {
                    "disable_password_authentication": true
                },
                "Blocks": [],
                "Labels": [],
                "Type": "os_profile_linux_config",
                "line_range": {
                    "endLine": 46,
                    "startLine": 44
                }
            }
        ],
        "Labels": [
            "azurerm_virtual_machine",
            "main"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 47,
            "startLine": 17
        }
    }]
	count(result) == 1
}

test_azure_vm_creds_in_custom_data_failed {
	result := failed with input as [{
        "Attributes": {},
        "Blocks": [
            {
                "Attributes": {},
                "Blocks": [],
                "Labels": [],
                "Type": "features",
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "Labels": [
            "azurerm"
        ],
        "Type": "provider",
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "location": "East US",
            "name": "example-resources"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_resource_group",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Attributes": {
            "address_space": [
                "10.0.0.0/16"
            ],
            "location": "azurerm_resource_group.example.location",
            "name": "example-network",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_virtual_network",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 15,
            "startLine": 10
        }
    },
    {
        "Attributes": {
            "location": "azurerm_resource_group.example.location",
            "name": "var.prefix",
            "network_interface_ids": "azurerm_network_interface.example.id",
            "resource_group_name": "azurerm_resource_group.example.name",
            "vm_size": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Attributes": {
                    "offer": "UbuntuServer",
                    "publisher": "Canonical",
                    "sku": "16.04-LTS",
                    "version": "latest"
                },
                "Blocks": [],
                "Labels": [],
                "Type": "storage_image_reference",
                "line_range": {
                    "endLine": 29,
                    "startLine": 24
                }
            },
            {
                "Attributes": {
                    "admin_username": "adminuser",
                    "computer_name": "hostname",
                    "custom_data": "secret_value"
                },
                "Blocks": [],
                "Labels": [],
                "Type": "os_profile",
                "line_range": {
                    "endLine": 42,
                    "startLine": 31
                }
            },
            {
                "Attributes": {
                    "disable_password_authentication": true
                },
                "Blocks": [],
                "Labels": [],
                "Type": "os_profile_linux_config",
                "line_range": {
                    "endLine": 46,
                    "startLine": 44
                }
            }
        ],
        "Labels": [
            "azurerm_virtual_machine",
            "main"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 47,
            "startLine": 17
        }
    }]
	count(result) == 1
}
