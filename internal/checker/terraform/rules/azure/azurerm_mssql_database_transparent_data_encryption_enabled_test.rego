package lib.terraform.CB_TFAZR_222

test_azurerm_mssql_database_transparent_data_encryption_enabled_passed {
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
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "LRS",
                "account_tier": "Standard",
                "location": "azurerm_resource_group.example.location",
                "name": "examplesa",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 16,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_mssql_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "4dm1n157r470r",
                "administrator_login_password": "4-v3ry-53cr37-p455w0rd",
                "location": "azurerm_resource_group.example.location",
                "name": "example-sqlserver",
                "resource_group_name": "azurerm_resource_group.example.name",
                "version": "12.0"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 25,
                "startLine": 18
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_mssql_database",
                "test"
            ],
            "Attributes": {
                "collation": "SQL_Latin1_General_CP1_CI_AS",
                "license_type": "LicenseIncluded",
                "max_size_gb": "4",
                "name": "acctest-db-d",
                "read_scale": true,
                "server_id": "azurerm_mssql_server.example.id",
                "sku_name": "S0",
                "tags": {
                    "foo": "bar"
                },
                "transparent_data_encryption_enabled": true,
                "zone_redundant": true
            },
            "Blocks": [],
            "line_range": {
                "endLine": 41,
                "startLine": 27
            }
        }
    ]
    count(result) == 1
}

test_azurerm_mssql_database_transparent_data_encryption_enabled_failed {
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
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "LRS",
                "account_tier": "Standard",
                "location": "azurerm_resource_group.example.location",
                "name": "examplesa",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 16,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_mssql_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "4dm1n157r470r",
                "administrator_login_password": "4-v3ry-53cr37-p455w0rd",
                "location": "azurerm_resource_group.example.location",
                "name": "example-sqlserver",
                "resource_group_name": "azurerm_resource_group.example.name",
                "version": "12.0"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 25,
                "startLine": 18
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_mssql_database",
                "test"
            ],
            "Attributes": {
                "collation": "SQL_Latin1_General_CP1_CI_AS",
                "license_type": "LicenseIncluded",
                "max_size_gb": "4",
                "name": "acctest-db-d",
                "read_scale": true,
                "server_id": "azurerm_mssql_server.example.id",
                "sku_name": "S0",
                "tags": {
                    "foo": "bar"
                },
                "transparent_data_encryption_enabled": false,
                "zone_redundant": true
            },
            "Blocks": [],
            "line_range": {
                "endLine": 41,
                "startLine": 27
            }
        }
    ]
    count(result) == 1
}