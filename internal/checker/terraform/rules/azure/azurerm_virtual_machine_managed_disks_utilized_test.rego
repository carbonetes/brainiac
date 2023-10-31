package lib.terraform.CB_TFAZR_220

test_azurerm_virtual_machine_managed_disks_utilized {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_virtual_machine",
			"virtual_machine_good",
		],
		"Attributes": {
			"location": "location",
			"name": "my-vm",
			"network_interface_ids": ["1234567"],
			"resource_group_name": "group_name",
			"tags": {"environment": "staging"},
			"vm_size": "Standard_DS1_v2",
		},
		"Blocks": [
			{
				"Type": "storage_image_reference",
				"Labels": [],
				"Attributes": {
					"offer": "UbuntuServer",
					"publisher": "Canonical",
					"sku": "16.04-LTS",
					"version": "latest",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 13,
					"startLine": 8,
				},
			},
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
					"endLine": 19,
					"startLine": 14,
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
					"endLine": 24,
					"startLine": 20,
				},
			},
			{
				"Type": "os_profile_linux_config",
				"Labels": [],
				"Attributes": {"disable_password_authentication": false},
				"Blocks": [],
				"line_range": {
					"endLine": 27,
					"startLine": 25,
				},
			},
		],
		"line_range": {
			"endLine": 31,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_virtual_machine_managed_disks_not_utilized {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_virtual_machine",
			"virtual_machine_good",
		],
		"Attributes": {
			"location": "location",
			"name": "my-vm",
			"network_interface_ids": ["1234567"],
			"resource_group_name": "group_name",
			"tags": {"environment": "staging"},
			"vm_size": "Standard_DS1_v2",
		},
		"Blocks": [
			{
				"Type": "storage_image_reference",
				"Labels": [],
				"Attributes": {
					"offer": "UbuntuServer",
					"publisher": "Canonical",
					"sku": "16.04-LTS",
					"version": "latest",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 13,
					"startLine": 8,
				},
			},
			{
				"Type": "storage_os_disk",
				"Labels": [],
				"Attributes": {
					"caching": "ReadWrite",
					"create_option": "FromImage",
					"name": "myosdisk1",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 19,
					"startLine": 14,
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
					"endLine": 24,
					"startLine": 20,
				},
			},
			{
				"Type": "os_profile_linux_config",
				"Labels": [],
				"Attributes": {"disable_password_authentication": false},
				"Blocks": [],
				"line_range": {
					"endLine": 27,
					"startLine": 25,
				},
			},
		],
		"line_range": {
			"endLine": 31,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
