package lib.terraform.CB_TFAZR_145

test_azurerm_web_pubsub_sku_uses_sla_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "east us",
                "name": "terraform-webpubsub"
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
                "azurerm_web_pubsub",
                "example"
            ],
            "Attributes": {
                "capacity": "1",
                "location": "azurerm_resource_group.example.location",
                "name": "tfex-webpubsub",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard_S1"
            },
            "Blocks": [
                {
                    "Type": "live_trace",
                    "Labels": [],
                    "Attributes": {
                        "connectivity_logs_enabled": false,
                        "enabled": true,
                        "messaging_logs_enabled": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 20,
                        "startLine": 16
                    }
                },
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "SystemAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 22
                    }
                }
            ],
            "line_range": {
                "endLine": 25,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_web_pubsub_sku_uses_sla_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "example"
        ],
        "Attributes": {
            "location": "east us",
            "name": "terraform-webpubsub"
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
            "azurerm_web_pubsub",
            "example"
        ],
        "Attributes": {
            "capacity": "1",
            "location": "azurerm_resource_group.example.location",
            "name": "tfex-webpubsub",
            "public_network_access_enabled": false,
            "resource_group_name": "azurerm_resource_group.example.name",
            "sku": "Free_F1"
        },
        "Blocks": [
            {
                "Type": "live_trace",
                "Labels": [],
                "Attributes": {
                    "connectivity_logs_enabled": false,
                    "enabled": true,
                    "messaging_logs_enabled": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 20,
                    "startLine": 16
                }
            },
            {
                "Type": "identity",
                "Labels": [],
                "Attributes": {
                    "type": "SystemAssigned"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 24,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 25,
            "startLine": 6
        }
    }
]
    count(result) == 1
}
