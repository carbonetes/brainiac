package lib.terraform.CB_TFAZR_052

test_azure_app_service_dot_net_framework_version_passed {
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
            "azurerm_app_service",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "site_config",
                "Labels": [],
                "Attributes": {
                    "dotnet_framework_version": "v6.0"
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
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_app_service_dot_net_framework_version_failed {
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
            "azurerm_app_service",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "site_config",
                "Labels": [],
                "Attributes": {
                    "dotnet_framework_version": "v4.0"
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
            "startLine": 10
        }
    }]
	count(result) == 1
}