package lib.terraform.CB_TFAZR_072

test_managed_disks_use_cmk_encryption {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_managed_disk",
			"test",
		],
		"Attributes": {"disk_encryption_set_id": "carbo"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_managed_disks_does_not_use_cmk_encryption {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_managed_disk",
			"test",
		],
		"Attributes": {"location": "use-west-2"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
