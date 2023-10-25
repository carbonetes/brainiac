package lib.terraform.CB_TFAZR_224

test_azurerm_postgresql_flexible_server_firewall_rule_not_overly_permissive_network_access_passed {
	result := passed with input as [
        {
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
                "location": "West Europe",
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
                "azurerm_postgresql_flexible_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "psqladmin",
                "administrator_password": "H@Sh1CoR3!",
                "location": "azurerm_resource_group.example.location",
                "name": "example-psqlflexibleserver",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "GP_Standard_D4s_v3",
                "storage_mb": "32768",
                "version": "12"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 21,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_postgresql_flexible_server_firewall_rule",
                "example"
            ],
            "Attributes": {
                "end_ip_address": "122.122.0.0",
                "name": "example-fw",
                "server_id": "azurerm_postgresql_flexible_server.example.id",
                "start_ip_address": "122.122.0.0"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 28,
                "startLine": 23
            }
        }
    ]
    count(result) == 1
}

test_azurerm_postgresql_flexible_server_firewall_rule_not_overly_permissive_network_access_failed {
	result := failed with input as [
        {
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
                "location": "West Europe",
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
                "azurerm_postgresql_flexible_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "psqladmin",
                "administrator_password": "H@Sh1CoR3!",
                "location": "azurerm_resource_group.example.location",
                "name": "example-psqlflexibleserver",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "GP_Standard_D4s_v3",
                "storage_mb": "32768",
                "version": "12"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 21,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_postgresql_flexible_server_firewall_rule",
                "example"
            ],
            "Attributes": {
                "end_ip_address": "255.255.255.255",
                "name": "example-fw",
                "server_id": "azurerm_postgresql_flexible_server.example.id",
                "start_ip_address": "0.0.0.0"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 28,
                "startLine": 23
            }
        }
    ]
    count(result) == 1
}