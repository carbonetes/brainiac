package lib.terraform.CB_TFAWS_224
import rego.v1

test_api_gateway_methond_setting_caching_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_method_settings",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {
				"cache_data_encrypted": true,
				"cache_ttl_seconds": "300",
				"caching_enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_api_gateway_methond_setting_caching_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_method_settings",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {
				"cache_data_encrypted": true,
				"cache_ttl_seconds": "300",
				"caching_enabled": false,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
