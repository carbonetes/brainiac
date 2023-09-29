package lib.terraform.CB_TFAZR_091

test_azurerm_storage_sync_public_access_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_sync",
			"test",
		],
		"Attributes": {"incoming_traffic_policy": "AllowVirtualNetworksOnly"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_storage_sync_public_access_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_sync",
			"test",
		],
		"Attributes": {"incoming_traffic_policy": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
