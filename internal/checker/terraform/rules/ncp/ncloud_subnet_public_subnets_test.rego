package lib.terraform.CB_TFNCP_020

test_ncloud_subnet_public_subnets_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"ncloud_route_table_association",
				"existing_public_association",
			],
			"Attributes": {
				"route_table_id": "ncloud_route_table.public_route_table.id",
				"route_table_type": "CUSTOM",
				"subnet_id": "ncloud_subnet.public_subnet.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 17,
				"startLine": 13,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_subnet",
				"public_subnet",
			],
			"Attributes": {"subnet_type": "PUBLIC"},
			"Blocks": [],
			"line_range": {
				"endLine": 22,
				"startLine": 19,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_route_table",
				"public_route_table",
			],
			"Attributes": {"supported_subnet_type": "PUBLIC"},
			"Blocks": [],
			"line_range": {
				"endLine": 27,
				"startLine": 24,
			},
		},
	]
	count(result) == 1
}

test_ncloud_subnet_public_subnets_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"ncloud_route_table_association",
				"existing_public_association",
			],
			"Attributes": {"route_table_type": "CUSTOM"},
			"Blocks": [],
			"line_range": {
				"endLine": 17,
				"startLine": 13,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_subnet",
				"public_subnet",
			],
			"Attributes": {"subnet_type": ""},
			"Blocks": [],
			"line_range": {
				"endLine": 22,
				"startLine": 19,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_route_table",
				"public_route_table",
			],
			"Attributes": {"supported_subnet_type": ""},
			"Blocks": [],
			"line_range": {
				"endLine": 27,
				"startLine": 24,
			},
		},
	]
	count(result) == 1
}
