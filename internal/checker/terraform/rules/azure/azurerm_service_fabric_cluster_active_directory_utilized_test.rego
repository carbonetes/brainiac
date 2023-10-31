package lib.terraform.CB_TFAZR_108

test_azurerm_service_fabric_cluster_active_directory_utilized {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_service_fabric_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "azure_active_directory",
			"Labels": [],
			"Attributes": {"tenant_id": "tenant"},
			"Blocks": [],
			"linªeª_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_service_fabric_cluster_active_directory_not_utilized {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_service_fabric_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "azure_active_directory",
			"Labels": [],
			"Attributes": {"not_tenant_id": "tenant"},
			"Blocks": [],
			"linªeª_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
