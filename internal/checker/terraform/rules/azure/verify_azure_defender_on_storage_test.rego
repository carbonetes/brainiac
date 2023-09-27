package lib.terraform.CB_TFAZR_076

test_azure_defender_on_storage_passed {
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
            "azurerm_security_center_subscription_pricing",
            "example"
        ],
        "Attributes": {
            "resource_type": "AppServices,ContainerRegistry,KeyVaults,KubernetesService,SqlServers,SqlServerVirtualMachines,StorageAccounts,VirtualMachines,ARM,DNS",
            "tier": "Standard"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_defender_on_storage_failed {
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
            "azurerm_security_center_subscription_pricing",
            "example"
        ],
        "Attributes": {
            "resource_type": "StorageAccounts",
            "tier": "notStandard"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 10
        }
    }]
	count(result) == 1
}