package lib.terraform.CB_TFPAN_001

test_panos_no_hardcoded_in_provider_passed {
	result := passed with input as [
		{
			"Type": "provider",
			"Labels": ["panos"],
			"Attributes": {
				"api_key": "var.panos_api_key",
				"hostname": "panos.example.com",
				"password": "var.panos_password",
				"username": "admin",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 1,
			},
		},
		{
			"Type": "variable",
			"Labels": ["panos_api_key"],
			"Attributes": {"description": "PAN-OS API key"},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 9,
			},
		},
		{
			"Type": "variable",
			"Labels": ["panos_password"],
			"Attributes": {
				"default": "your_default_password",
				"description": "PAN-OS password",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 16,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}

test_panos_no_hardcoded_in_provider_failed {
	result := failed with input as [
		{
			"Type": "provider",
			"Labels": ["panos"],
			"Attributes": {
				"api_key": "hardcoded_sample",
				"hostname": "panos.example.com",
				"password": "hardcoded_sample",
				"username": "admin",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 1,
			},
		},
		{
			"Type": "variable",
			"Labels": ["panos_api_key"],
			"Attributes": {"description": "PAN-OS API key"},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 9,
			},
		},
		{
			"Type": "variable",
			"Labels": ["panos_password"],
			"Attributes": {
				"default": "your_default_password",
				"description": "PAN-OS password",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 16,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}
