package lib.terraform.CB_TFAZR_001

test_azure_instance_basic_auth_not_set {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_linux_virtual_machine",
			"example",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "admin_ssh_keys",
				"Labels": [],
				"Attributes": {"username": "adminuser"},
				"Blocks": [],
				"line_range": {
					"endLine": 6,
					"startLine": 3,
				},
			},
			{
				"Type": "os_profile_linux_config",
				"Labels": [],
				"Attributes": {"disable_password_authentication": true},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 7,
				},
			},
		],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azure_instance_basic_auth_is_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_linux_virtual_machine",
			"example",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "admin_ssh_keys",
				"Labels": [],
				"Attributes": {"username": "adminuser"},
				"Blocks": [],
				"line_range": {
					"endLine": 6,
					"startLine": 3,
				},
			},
			{
				"Type": "os_profile_linux_config",
				"Labels": [],
				"Attributes": {"disable_password_authentication": false},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 7,
				},
			},
		],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
