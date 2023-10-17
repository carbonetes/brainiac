package lib.terraform.CB_TFAZR_192

test_azurerm_signalr_service_uses_paid_sku_for_sla_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "terraform-signalr"
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
                "azurerm_signalr_service",
                "example"
            ],
            "Attributes": {
                "connectivity_logs_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "messaging_logs_enabled": true,
                "name": "tfex-signalr",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "service_mode": "Default"
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "capacity": "1",
                        "name": "Premium_P1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 11
                    }
                },
                {
                    "Type": "cors",
                    "Labels": [],
                    "Attributes": {
                        "allowed_origins": [
                            "http://www.example.com"
                        ]
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 18,
                        "startLine": 16
                    }
                },
                {
                    "Type": "upstream_endpoint",
                    "Labels": [],
                    "Attributes": {
                        "category_pattern": [
                            "connections",
                            "messages"
                        ],
                        "event_pattern": [
                            "*"
                        ],
                        "hub_pattern": [
                            "hub1"
                        ],
                        "url_template": "http://foo.com"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 32,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_signalr_service_uses_paid_sku_for_sla_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "terraform-signalr"
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
                "azurerm_signalr_service",
                "example"
            ],
            "Attributes": {
                "connectivity_logs_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "messaging_logs_enabled": true,
                "name": "tfex-signalr",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "service_mode": "Default"
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "capacity": "1",
                        "name": "Free_F1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 11
                    }
                },
                {
                    "Type": "cors",
                    "Labels": [],
                    "Attributes": {
                        "allowed_origins": [
                            "http://www.example.com"
                        ]
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 18,
                        "startLine": 16
                    }
                },
                {
                    "Type": "upstream_endpoint",
                    "Labels": [],
                    "Attributes": {
                        "category_pattern": [
                            "connections",
                            "messages"
                        ],
                        "event_pattern": [
                            "*"
                        ],
                        "hub_pattern": [
                            "hub1"
                        ],
                        "url_template": "http://foo.com"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 32,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}