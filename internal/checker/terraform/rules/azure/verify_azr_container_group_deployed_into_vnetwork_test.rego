package lib.terraform.CB_TFAZR_080

test_azr_container_group_deployed_into_vnetwork {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_container_group",
			"example",
		],
		"Attributes": {"subnet_ids": "var.test.carbo"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azr_container_group_not_deployed_into_vnetwork {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_container_group",
			"example",
		],
		"Attributes": {"network_profile_id": "var.test.carbo"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
