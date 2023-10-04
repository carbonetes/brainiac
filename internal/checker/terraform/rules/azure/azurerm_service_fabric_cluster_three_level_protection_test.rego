package lib.terraform.CB_TFAZR_101

test_azurerm_service_fabric_cluster_three_level_protection_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_service_fabric_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "fabric_settings",
			"Labels": [],
			"Attributes": {
				"name": "Security",
				"parameters": {
					"name": "ClusterProtectionLevel",
					"value": "EncryptAndSign",
				},
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_service_fabric_cluster_three_level_protection_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_service_fabric_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
