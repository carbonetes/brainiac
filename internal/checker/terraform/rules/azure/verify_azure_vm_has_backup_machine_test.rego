package lib.terraform.CB_TFAZR_208

test_azure_vm_has_backup_machine_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_virtual_machine",
            "example_ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.main.location",
            "name": "var.prefix",
            "network_interface_ids": "azurerm_network_interface.main.id",
            "resource_group_name": "azurerm_resource_group.main.name",
            "vm_size": "Standard_DS1_v2"
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
            "azurerm_backup_protected_vm",
            "vm_protected_backup"
        ],
        "Attributes": {
            "backup_policy_id": "azurerm_backup_policy_vm.example_ok.id",
            "recovery_vault_name": "azurerm_recovery_services_vault.example_ok.name",
            "resource_group_name": "azurerm_resource_group.example_ok.name",
            "source_vm_id": "azurerm_virtual_machine.example_ok.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 9
        }
    }]
	count(result) == 1
}

test_azure_vm_has_backup_machine_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_virtual_machine",
            "example_ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.main.location",
            "name": "var.prefix",
            "network_interface_ids": "azurerm_network_interface.main.id",
            "resource_group_name": "azurerm_resource_group.main.name",
            "vm_size": "Standard_DS1_v2"
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
            "azurerm_backup_protected_vm",
            "vm_protected_backup"
        ],
        "Attributes": {
            "backup_policy_id": "azurerm_backup_policy_vm.example_ok.id",
            "recovery_vault_name": "azurerm_recovery_services_vault.example_ok.name",
            "resource_group_name": "azurerm_resource_group.example_ok.name",
            "source_vm_id": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 9
        }
    }]
	count(result) == 1
}