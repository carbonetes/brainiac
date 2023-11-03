package lib.terraform.CB_TFAZR_042

test_azure_managed_disk_encryption_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_managed_disk",
			"example",
		],
		"Attributes": {
			"create_option": "Empty",
			"disk_size_gb": "var.disk_size_gb",
			"location": "var.location",
			"name": "var.disk_name",
			"resource_group_name": "var.resource_group_name",
			"storage_account_type": "var.storage_account_type",
			"tags": "var.common_tags",
		},
		"Blocks": [{
			"Type": "encryption_settings",
			"Labels": [],
			"Attributes": {"enabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azure_managed_disk_encryption_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_managed_disk",
			"example",
		],
		"Attributes": {
			"create_option": "Empty",
			"disk_size_gb": "var.disk_size_gb",
			"location": "var.location",
			"name": "var.disk_name",
			"resource_group_name": "var.resource_group_name",
			"storage_account_type": "var.storage_account_type",
			"tags": "var.common_tags",
		},
		"Blocks": [{
			"Type": "encryption_settings",
			"Labels": [],
			"Attributes": {"enabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
