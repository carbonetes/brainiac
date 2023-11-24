package lib.terraform.CB_TFGCP_036

test_rsasha1_not_used {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_dns_managed_zone",
			"foo",
		],
		"Attributes": {
			"dns_name": "foo.bar.",
			"name": "foobar",
		},
		"Blocks": [{
			"Type": "zone_signing_keys",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_rsasha1_used {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_dns_managed_zone",
			"foo",
		],
		"Attributes": {
			"dns_name": "foo.bar.",
			"name": "foobar",
		},
		"Blocks": [{
			"Type": "zone_signing_keys",
			"Labels": [],
			"Attributes": {"algorithm": "rsasha1"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
