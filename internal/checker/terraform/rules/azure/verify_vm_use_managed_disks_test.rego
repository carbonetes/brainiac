package lib.terraform.CB_TFAZR_066

test_vm_use_managed_disk {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_windows_virtual_machine",
			"virtual_machine",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "storage_os_disk",
				"Labels": [],
				"Attributes": {
					"caching": "ReadWrite",
					"create_option": "FromImage",
					"managed_disk_type": "Standard_LRS",
					"name": "myosdisk1",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 2,
				},
			},
			{
				"Type": "os_profile",
				"Labels": [],
				"Attributes": {
					"admin_password": "Password1234!",
					"admin_username": "testadmin",
					"computer_name": "hostname",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 8,
				},
			},
		],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_vm_not_use_managed_disk {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_windows_virtual_machine",
			"virtual_machine",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "storage_os_disk",
				"Labels": [],
				"Attributes": {
					"caching": "ReadWrite",
					"create_option": "FromImage",
					"vhd_uri": "test_uri",
					"name": "myosdisk1",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 2,
				},
			},
			{
				"Type": "os_profile",
				"Labels": [],
				"Attributes": {
					"admin_password": "Password1234!",
					"admin_username": "testadmin",
					"computer_name": "hostname",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 8,
				},
			},
		],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
