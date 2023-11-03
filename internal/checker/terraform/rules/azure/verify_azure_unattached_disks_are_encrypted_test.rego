package lib.terraform.CB_TFAZR_242

test_azure_unattached_disks_are_encrypted_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "group"
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
            "azurerm_managed_disk",
            "managed_disk_good_1"
        ],
        "Attributes": {
            "create_option": "Empty",
            "disk_size_gb": "1",
            "location": "West US 2",
            "name": "acctestmd",
            "resource_group_name": "azurerm_resource_group.group.name",
            "storage_account_type": "Standard_LRS",
            "tags": {
                "environment": "staging"
            }
        },
        "Blocks": [
            {
                "Type": "encryption_settings",
                "Labels": [],
                "Attributes": {
                    "enabled": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 16,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 20,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_virtual_machine",
            "virtual_machine_good_1"
        ],
        "Attributes": {
            "location": "location",
            "name": "$vm",
            "network_interface_ids": [
                "id"
            ],
            "resource_group_name": "azurerm_resource_group.group.name",
            "vm_size": "Standard_DS1_v2"
        },
        "Blocks": [
            {
                "Type": "storage_image_reference",
                "Labels": [],
                "Attributes": {
                    "offer": "UbuntuServer",
                    "publisher": "Canonical",
                    "sku": "16.04-LTS",
                    "version": "latest"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 35,
                    "startLine": 30
                }
            },
            {
                "Type": "storage_os_disk",
                "Labels": [],
                "Attributes": {
                    "caching": "ReadWrite",
                    "create_option": "FromImage",
                    "managed_disk_id": "azurerm_managed_disk.managed_disk_good_1.id",
                    "name": "myosdisk1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 41,
                    "startLine": 36
                }
            }
        ],
        "line_range": {
            "endLine": 42,
            "startLine": 24
        }
    }
]
	count(result) == 1
}

test_azure_unattached_disks_are_encrypted_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "group"
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
            "azurerm_managed_disk",
            "managed_disk_good_1"
        ],
        "Attributes": {
            "create_option": "Empty",
            "disk_size_gb": "1",
            "location": "West US 2",
            "name": "acctestmd",
            "resource_group_name": "azurerm_resource_group.group.name",
            "storage_account_type": "Standard_LRS",
            "tags": {
                "environment": "staging"
            }
        },
        "Blocks": [
            {
                "Type": "encryption_settings",
                "Labels": [],
                "Attributes": {
                    "enabled": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 16,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 20,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_virtual_machine",
            "virtual_machine_good_1"
        ],
        "Attributes": {
            "location": "location",
            "name": "$vm",
            "network_interface_ids": [
                "id"
            ],
            "resource_group_name": "azurerm_resource_group.group.name",
            "vm_size": "Standard_DS1_v2"
        },
        "Blocks": [
            {
                "Type": "storage_image_reference",
                "Labels": [],
                "Attributes": {
                    "offer": "UbuntuServer",
                    "publisher": "Canonical",
                    "sku": "16.04-LTS",
                    "version": "latest"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 35,
                    "startLine": 30
                }
            },
            {
                "Type": "storage_os_disk",
                "Labels": [],
                "Attributes": {
                    "caching": "ReadWrite",
                    "create_option": "FromImage",
                    "managed_disk_id": "",
                    "name": "myosdisk1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 41,
                    "startLine": 36
                }
            }
        ],
        "line_range": {
            "endLine": 42,
            "startLine": 24
        }
    }
]
	count(result) == 1
}