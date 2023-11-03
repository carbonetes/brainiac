package lib.terraform.CB_TFAZR_038

test_azure_automation_encrypted_passed {
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
            "azurerm_automation_variable_bool",
            "example_bool"
        ],
        "Attributes": {
            "automation_account_name": "azurerm_automation_account.example.name",
            "encrypted": true,
            "name": "example-variable-bool",
            "resource_group_name": "azurerm_resource_group.example.name",
            "value": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 16,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_automation_encrypted_failed {
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
            "azurerm_automation_variable_bool",
            "example_bool"
        ],
        "Attributes": {
            "automation_account_name": "azurerm_automation_account.example.name",
            "encrypted": false,
            "name": "example-variable-bool",
            "resource_group_name": "azurerm_resource_group.example.name",
            "value": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 16,
            "startLine": 10
        }
    }]
	count(result) == 1
}
