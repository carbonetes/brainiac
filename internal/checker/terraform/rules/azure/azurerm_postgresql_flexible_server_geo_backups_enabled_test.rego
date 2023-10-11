package lib.terraform.CB_TFAZR_168

test_azurerm_postgresql_flexible_server_geo_backups_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_postgresql_flexible_server"],
		"Attributes": {
			"administrator_login": "psqladmin",
			"administrator_password": "H@Sh1CoR3!",
			"delegated_subnet_id": "azurerm_subnet.example.id",
			"depends_on": ["azurerm_private_dns_zone_virtual_network_link.example"],
			"geo_redundant_backup_enabled": true,
			"location": "azurerm_resource_group.example.location",
			"name": "example-psqlflexibleserver",
			"private_dns_zone_id": "azurerm_private_dns_zone.example.id",
			"resource_group_name": "azurerm_resource_group.example.name",
			"sku_name": "GP_Standard_D4s_v3",
			"storage_mb": "32768",
			"version": "12",
			"zone": "1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_postgresql_flexible_server_geo_backups_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": ["azurerm_postgresql_flexible_server"],
		"Attributes": {
			"administrator_login": "psqladmin",
			"administrator_password": "H@Sh1CoR3!",
			"delegated_subnet_id": "azurerm_subnet.example.id",
			"depends_on": ["azurerm_private_dns_zone_virtual_network_link.example"],
			"geo_redundant_backup_enabled": false,
			"location": "azurerm_resource_group.example.location",
			"name": "example-psqlflexibleserver",
			"private_dns_zone_id": "azurerm_private_dns_zone.example.id",
			"resource_group_name": "azurerm_resource_group.example.name",
			"sku_name": "GP_Standard_D4s_v3",
			"storage_mb": "32768",
			"version": "12",
			"zone": "1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]

	count(result) == 1
}
