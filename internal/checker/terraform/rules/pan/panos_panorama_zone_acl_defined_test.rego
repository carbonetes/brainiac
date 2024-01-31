package lib.terraform.CB_TFPAN_015

test_panos_panorama_zone_acl_defined_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_zone",
			"example_zone",
		],
		"Attributes": {
			"enable_user_id": true,
			"include_acls": ["example_acl"],
			"name": "example_zone",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_panos_panorama_zone_acl_defined_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_zone",
			"example_zone",
		],
		"Attributes": {
			"enable_user_id": true,
			"include_acls": [""],
			"name": "example_zone",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
