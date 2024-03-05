package lib.terraform.CB_TFDIO_001

test_digitalocean_spaces_bucket_versioning_active_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_spaces_bucket",
			"example",
		],
		"Attributes": {
			"name": "example-bucket",
			"region": "nyc3",
		},
		"Blocks": [{
			"Type": "versioning",
			"Labels": [],
			"Attributes": {"enabled": true},
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

test_digitalocean_spaces_bucket_versioning_active_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_spaces_bucket",
			"example",
		],
		"Attributes": {
			"name": "example-bucket",
			"region": "nyc3",
		},
		"Blocks": [{
			"Type": "versioning",
			"Labels": [],
			"Attributes": {"enabled": false},
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
