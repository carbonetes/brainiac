package lib.terraform.CB_TFAZR_097

test_azurerm_security_center_subscription_pricing_azure_defender_enabled_on_servers_enabled {
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

test_azurerm_security_center_subscription_pricing_azure_defender_enabled_on_servers_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_subscription_pricing",
			"example",
		],
		"Attributes": {
			"resource_type": "VirtualMachines",
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
