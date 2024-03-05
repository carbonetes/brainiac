package lib.terraform.CB_TFLIN_006

test_linode_provider_no_hardcoded_passed {
	result := passed with input as [
		{
			"Type": "variable",
			"Labels": ["linode_token"],
			"Attributes": {"description": "Linode API token"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "provider",
			"Labels": ["linode"],
			"Attributes": {"token": "var.linode_token"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_linode_provider_no_hardcoded_failed {
	result := failed with input as [
		{
			"Type": "variable",
			"Labels": ["linode_token"],
			"Attributes": {"description": "Linode API token"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "provider",
			"Labels": ["linode"],
			"Attributes": {"token": "hardcoded_sample"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}
