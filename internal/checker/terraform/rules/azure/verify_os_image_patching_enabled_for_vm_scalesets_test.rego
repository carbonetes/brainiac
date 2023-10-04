package lib.terraform.CB_TFAZR_075

test_os_image_patching_enabled_for_vm {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_virtual_machine_scale_set",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "os_profile_windows_config",
			"Labels": [],
			"Attributes": {"enable_automatic_upgrades": true},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_os_image_patching_disabled_for_vm {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_virtual_machine_scale_set",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "os_profile_windows_config",
			"Labels": [],
			"Attributes": {"enable_automatic_upgrades": false},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
