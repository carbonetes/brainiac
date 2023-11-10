package lib.terraform.CB_TFGCP_035

test_dnssec_enabled_cloud_dns {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_dns_managed_zone",
			"example",
		],
		"Attributes": {
			"description": "Company Domain name",
			"dns_name": "example.com.",
		},
		"Blocks": [{
			"Type": "dnssec_config",
			"Labels": [],
			"Attributes": {"state": "on"},
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

test_dnssec_not_enabled_cloud_dns {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_dns_managed_zone",
			"example",
		],
		"Attributes": {
			"description": "Company Domain name",
			"dns_name": "example.com.",
		},
		"Blocks": [{
			"Type": "dnssec_config",
			"Labels": [],
			"Attributes": {"state": "off"},
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
