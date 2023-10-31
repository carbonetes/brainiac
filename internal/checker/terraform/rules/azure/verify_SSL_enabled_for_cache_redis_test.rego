package lib.terraform.CB_TFAZR_065

test_only_SSL_enabled_for_cache_redis {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_redis_cache",
			"example",
		],
		"Attributes": {"enable_non_ssl_port": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_only_SSL_enabled_for_cache_redis_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_redis_cache",
			"example",
		],
		"Attributes": {"enable_non_ssl_port": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
