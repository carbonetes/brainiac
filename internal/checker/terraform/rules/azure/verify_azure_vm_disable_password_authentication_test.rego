package lib.terraform.CB_TFAZR_134

test_azure_vm_disable_password_authentication_passed {
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
            "azurerm_linux_virtual_machine_scale_set",
            "pass"
        ],
        "Attributes": {
            "admin_username": "var.admin_username",
            "disable_password_authentication": true,
            "instances": "var.instance_count",
            "location": "var.resource_group.location",
            "name": "var.scaleset_name",
            "resource_group_name": "var.resource_group.name",
            "sku": "var.sku",
            "tags": {
                "test": "Fail"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_vm_disable_password_authentication_failed {
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
            "azurerm_linux_virtual_machine_scale_set",
            "pass"
        ],
        "Attributes": {
            "admin_username": "var.admin_username",
            "disable_password_authentication": false,
            "instances": "var.instance_count",
            "location": "var.resource_group.location",
            "name": "var.scaleset_name",
            "resource_group_name": "var.resource_group.name",
            "sku": "var.sku",
            "tags": {
                "test": "Fail"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 5
        }
    }]
	count(result) == 1
}