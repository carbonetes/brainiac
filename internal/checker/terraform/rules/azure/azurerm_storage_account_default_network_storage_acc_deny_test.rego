package lib.terraform.CB_TFAZR_011

test_azurerm_storage_account_default_network_storage_acc_deny {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"test",
		],
		"Attributes": {
			"account_kind": "StorageV2",
			"account_replication_type": "LRS",
			"account_tier": "Standard",
			"enable_https_traffic_only": true,
			"location": "azurerm_resource_group.test.location",
			"name": "var.watcher",
			"resource_group_name": "azurerm_resource_group.test.name",
		},
		"Blocks": [{
			"Type": "network_rules",
			"Labels": [],
			"Attributes": {"default_action": "Deny"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_storage_account_default_network_storage_acc_allow {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"test",
		],
		"Attributes": {
			"account_kind": "StorageV2",
			"account_replication_type": "LRS",
			"account_tier": "Standard",
			"enable_https_traffic_only": true,
			"location": "azurerm_resource_group.test.location",
			"name": "var.watcher",
			"resource_group_name": "azurerm_resource_group.test.name",
		},
		"Blocks": [{
			"Type": "network_rules",
			"Labels": [],
			"Attributes": {"default_action": "Allow"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
