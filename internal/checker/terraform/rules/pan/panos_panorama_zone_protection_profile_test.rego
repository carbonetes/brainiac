package lib.terraform.CB_TFPAN_014

test_panos_panorama_zone_protection_profile_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"panos_zone",
				"example_zone",
			],
			"Attributes": {
				"name": "example_zone",
				"zone_profile": "var.zone_protection_profile_name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "variable",
			"Labels": ["zone_protection_profile_name"],
			"Attributes": {
				"description": "Name of the Zone Protection Profile",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

test_panos_panorama_zone_protection_profile_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"panos_zone",
				"example_zone",
			],
			"Attributes": {
				"name": "example_zone",
				"zone_profile": "",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "variable",
			"Labels": ["zone_protection_profile_name"],
			"Attributes": {
				"description": "Name of the Zone Protection Profile",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}
