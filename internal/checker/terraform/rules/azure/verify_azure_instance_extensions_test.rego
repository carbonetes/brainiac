package lib.terraform.CB_TFAZR_022

test_verify_azure_instance_extensions_passed {
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
            "azurerm_linux_virtual_machine",
            "example"
        ],
        "Attributes": {
            "admin_username": "your_linux_admin_username",
            "allow_extension_operations": false,
            "location": "azurerm_resource_group.example.location",
            "name": "example-linux-vm",
            "network_interface_ids": "azurerm_network_interface.example.id",
            "resource_group_name": "azurerm_resource_group.example.name",
            "size": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Type": "admin_ssh_key",
                "Labels": [],
                "Attributes": {
                    "username": "your_linux_admin_username"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 18
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
                    "endLine": 25,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 11
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_windows_virtual_machine",
            "example"
        ],
        "Attributes": {
            "admin_password": "your_windows_admin_password",
            "admin_username": "your_windows_admin_username",
            "allow_extension_operations": false,
            "disable_disk_encryption": true,
            "location": "azurerm_resource_group.example.location",
            "name": "example-windows-vm",
            "network_interface_ids": "azurerm_network_interface.example.id",
            "provision_vm_agent": false,
            "resource_group_name": "azurerm_resource_group.example.name",
            "size": "Standard_DS2_v2"
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
                    "endLine": 44,
                    "startLine": 41
                }
            }
        ],
        "line_range": {
            "endLine": 47,
            "startLine": 30
        }
    }]
	count(result) == 1
}

test_verify_azure_instance_extensions_failed {
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
            "azurerm_linux_virtual_machine",
            "example"
        ],
        "Attributes": {
            "admin_username": "your_linux_admin_username",
            "allow_extension_operations": true,
            "location": "azurerm_resource_group.example.location",
            "name": "example-linux-vm",
            "network_interface_ids": "azurerm_network_interface.example.id",
            "resource_group_name": "azurerm_resource_group.example.name",
            "size": "Standard_DS2_v2"
        },
        "Blocks": [
            {
                "Type": "admin_ssh_key",
                "Labels": [],
                "Attributes": {
                    "username": "your_linux_admin_username"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 18
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
                    "endLine": 25,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 11
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_windows_virtual_machine",
            "example"
        ],
        "Attributes": {
            "admin_password": "your_windows_admin_password",
            "admin_username": "your_windows_admin_username",
            "allow_extension_operations": true,
            "disable_disk_encryption": true,
            "location": "azurerm_resource_group.example.location",
            "name": "example-windows-vm",
            "network_interface_ids": "azurerm_network_interface.example.id",
            "provision_vm_agent": false,
            "resource_group_name": "azurerm_resource_group.example.name",
            "size": "Standard_DS2_v2"
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
                    "endLine": 44,
                    "startLine": 41
                }
            }
        ],
        "line_range": {
            "endLine": 47,
            "startLine": 30
        }
    }]
	count(result) == 1
}
