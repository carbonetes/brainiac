package lib.terraform.CB_TFAZR_090

test_azurerm_postgresql_server_geo_redundant_backup_enabled_passed {
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
                "azurerm_postgresql_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "psqladmin",
                "administrator_login_password": "H@Sh1CoR3!",
                "auto_grow_enabled": true,
                "backup_retention_days": "7",
                "geo_redundant_backup_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "name": "example-psqlserver",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "GP_Gen5_4",
                "ssl_enforcement_enabled": true,
                "ssl_minimal_tls_version_enforced": "TLS1_2",
                "storage_mb": "640000",
                "version": "11"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 25,
                "startLine": 6
            }
        }
    ]   
	count(result) == 1
}


test_azurerm_postgresql_server_geo_redundant_backup_enabled_failed {
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
                "azurerm_postgresql_server",
                "example"
            ],
            "Attributes": {
                "administrator_login": "psqladmin",
                "administrator_login_password": "H@Sh1CoR3!",
                "auto_grow_enabled": true,
                "backup_retention_days": "7",
                "geo_redundant_backup_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example-psqlserver",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "GP_Gen5_4",
                "ssl_enforcement_enabled": true,
                "ssl_minimal_tls_version_enforced": "TLS1_2",
                "storage_mb": "640000",
                "version": "11"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 25,
                "startLine": 6
            }
        }
    ]   
	count(result) == 1
}