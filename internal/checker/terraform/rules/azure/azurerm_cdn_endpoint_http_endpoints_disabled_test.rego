package lib.terraform.CB_TFAZR_193

test_azurerm_cdn_endpoint_http_endpoints_disabled_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
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
                "azurerm_cdn_profile",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-cdn",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard_Verizon"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 11,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_endpoint",
                "example"
            ],
            "Attributes": {
                "is_http_allowed": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "profile_name": "azurerm_cdn_profile.example.name",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "origin",
                    "Labels": [],
                    "Attributes": {
                        "host_name": "www.contoso.com",
                        "name": "example"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 22,
                        "startLine": 19
                    }
                }
            ],
            "line_range": {
                "endLine": 23,
                "startLine": 13
            }
        }
    ]
    count(result) == 1
}

test_azurerm_cdn_endpoint_http_endpoints_disabled_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
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
                "azurerm_cdn_profile",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-cdn",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard_Verizon"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 11,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_endpoint",
                "example"
            ],
            "Attributes": {
                "is_http_allowed": true,
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "profile_name": "azurerm_cdn_profile.example.name",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "origin",
                    "Labels": [],
                    "Attributes": {
                        "host_name": "www.contoso.com",
                        "name": "example"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 22,
                        "startLine": 19
                    }
                }
            ],
            "line_range": {
                "endLine": 23,
                "startLine": 13
            }
        }
    ]
    count(result) == 1
}