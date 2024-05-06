package lib.terraform.CB_TFAWS_031
import rego.v1

test_cloudfront_distribution_encryption_default_cache_behavior_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"example_distribution",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "default_cache_behavior",
			"Labels": [],
			"Attributes": {
				"allowed_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"cached_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"default_ttl": "3600",
				"max_ttl": "86400",
				"min_ttl": "0",
				"target_origin_id": "example-bucket-origin",
				"viewer_protocol_policy": "https-only",
			},
			"Blocks": [{
				"Type": "forwarded_values",
				"Labels": [],
				"Attributes": {"query_string": false},
				"Blocks": [{
					"Type": "cookies",
					"Labels": [],
					"Attributes": {"forward": "none"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				}],
				"line_range": {
					"endLine": 13,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 17,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudfront_distribution_encryption_default_cache_behavior_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"example_distribution",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "default_cache_behavior",
			"Labels": [],
			"Attributes": {
				"allowed_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"cached_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"default_ttl": "3600",
				"max_ttl": "86400",
				"min_ttl": "0",
				"target_origin_id": "example-bucket-origin",
				"viewer_protocol_policy": "allow-all",
			},
			"Blocks": [{
				"Type": "forwarded_values",
				"Labels": [],
				"Attributes": {"query_string": false},
				"Blocks": [{
					"Type": "cookies",
					"Labels": [],
					"Attributes": {"forward": "none"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				}],
				"line_range": {
					"endLine": 13,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 17,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudfront_distribution_encryption_ordered_cache_behavior_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"example_distribution",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "ordered_cache_behavior",
			"Labels": [],
			"Attributes": {
				"allowed_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"cached_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"default_ttl": "3600",
				"max_ttl": "86400",
				"min_ttl": "0",
				"target_origin_id": "example-bucket-origin",
				"viewer_protocol_policy": "https-only",
			},
			"Blocks": [{
				"Type": "forwarded_values",
				"Labels": [],
				"Attributes": {"query_string": false},
				"Blocks": [{
					"Type": "cookies",
					"Labels": [],
					"Attributes": {"forward": "none"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				}],
				"line_range": {
					"endLine": 13,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 17,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudfront_distribution_encryption_ordered_cache_behavior_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"example_distribution",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "ordered_cache_behavior",
			"Labels": [],
			"Attributes": {
				"allowed_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"cached_methods": [
					"GET",
					"HEAD",
					"OPTIONS",
				],
				"default_ttl": "3600",
				"max_ttl": "86400",
				"min_ttl": "0",
				"target_origin_id": "example-bucket-origin",
				"viewer_protocol_policy": "allow-all",
			},
			"Blocks": [{
				"Type": "forwarded_values",
				"Labels": [],
				"Attributes": {"query_string": false},
				"Blocks": [{
					"Type": "cookies",
					"Labels": [],
					"Attributes": {"forward": "none"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				}],
				"line_range": {
					"endLine": 13,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 17,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
