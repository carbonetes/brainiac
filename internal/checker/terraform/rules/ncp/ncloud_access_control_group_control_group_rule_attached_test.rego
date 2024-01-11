package lib.terraform.CB_TFNCP_025

test_ncloud_access_control_group_control_group_rule_attached_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"ncloud_access_control_group",
				"example_acg",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_access_control_group_rule",
				"example_acgr",
			],
			"Attributes": {"access_control_group_id": "ncloud_access_control_group.example_acg.id"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_ncloud_access_control_group_control_group_rule_attached_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"ncloud_access_control_group",
				"example_acg",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_access_control_group_rule",
				"example_acgr",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}
