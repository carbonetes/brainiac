package lib.terraform.CB_TFAZR_033

test_azure_app_service_identity_provider_enabled_passed {
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
            "azurerm_app_service",
            "example"
        ],
        "Attributes": {
            "app_service_plan_id": "azurerm_app_service_plan.example.id",
            "location": "East US",
            "name": "example-app-service",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [
            {
                "Type": "identity",
                "Labels": [],
                "Attributes": {
                    "type": "SystemAssigned"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 13,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 14,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_app_service_identity_provider_enabled_failed {
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
            "azurerm_app_service",
            "example"
        ],
        "Attributes": {
            "app_service_plan_id": "azurerm_app_service_plan.example.id",
            "location": "East US",
            "name": "example-app-service",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [
            {
                "Type": "identity",
                "Labels": [],
                "Attributes": {
                    "type": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 13,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 14,
            "startLine": 5
        }
    }]
	count(result) == 1
}
