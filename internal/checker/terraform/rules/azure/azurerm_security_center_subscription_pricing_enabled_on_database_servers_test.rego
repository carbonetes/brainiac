package lib.terraform.CB_TFAZR_099

test_azurerm_security_center_subscription_pricing_enabled_on_database_servers {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_subscription_pricing",
			"example",
		],
		"Attributes": {
			"resource_type": "AppServices,ContainerRegistry,KeyVaults,KubernetesService,SqlServers,SqlServerVirtualMachines,StorageAccounts,VirtualMachines,ARM,DNS",
			"tier": "Standard",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_security_center_subscription_pricing_disabled_on_database_servers {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_subscription_pricing",
			"example",
		],
		"Attributes": {
			"resource_type": "SqlServers",
			"tier": "NotStandard",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
