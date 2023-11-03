package lib.terraform.CB_TFAZR_113

test_azurerm_mssql_server_has_public_access_disabled_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "database-rg"
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
                "azurerm_mssql_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "missadministrator",
                "administrator_login_password": "thisIsKat11",
                "location": "azurerm_resource_group.example.location",
                "minimum_tls_version": "1.2",
                "name": "mssqlserver",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "production"
                },
                "version": "12.0"
            },
            "Blocks": [
                {
                    "Type": "azuread_administrator",
                    "Labels": [],
                    "Attributes": {
                        "login_username": "AzureAD Admin",
                        "object_id": "00000000-0000-0000-0000-000000000000"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 16
                    }
                }
            ],
            "line_range": {
                "endLine": 24,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_mssql_server_has_public_access_disabled_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "database-rg"
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
                "azurerm_mssql_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "missadministrator",
                "administrator_login_password": "thisIsKat11",
                "location": "azurerm_resource_group.example.location",
                "minimum_tls_version": "1.2",
                "name": "mssqlserver",
                "public_network_access_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "production"
                },
                "version": "12.0"
            },
            "Blocks": [
                {
                    "Type": "azuread_administrator",
                    "Labels": [],
                    "Attributes": {
                        "login_username": "AzureAD Admin",
                        "object_id": "00000000-0000-0000-0000-000000000000"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 16
                    }
                }
            ],
            "line_range": {
                "endLine": 24,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}