package lib.terraform.CB_TFAZR_079

test_vm_scale_set_have_host_encryption_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_windows_virtual_machine_scale_set",
			"example",
		],
		"Attributes": {"encryption_at_host_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_vm_scale_set_have_host_encryption_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_windows_virtual_machine_scale_set",
			"example",
		],
		"Attributes": {"encryption_at_host_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
