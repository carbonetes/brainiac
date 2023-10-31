package lib.terraform.CB_TFAZR_086

test_azurerm_security_center_subscription_pricing_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_security_center_subscription_pricing",
                "example"
            ],
            "Attributes": {
                "resource_type": "VirtualMachines",
                "tier": "Standard"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}

test_azurerm_security_center_subscription_pricing_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_security_center_subscription_pricing",
                "example"
            ],
            "Attributes": {
                "resource_type": "VirtualMachines",
                "tier": "Substandard"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}