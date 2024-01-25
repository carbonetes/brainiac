package lib.terraform.CB_TFDIO_003

test_digitalocean_spaces_bucket_private_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_spaces_bucket",
			"example",
		],
		"Attributes": {
			"acl": "private",
			"name": "example-bucket",
			"region": "nyc3",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_digitalocean_spaces_bucket_private_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_spaces_bucket",
			"example",
		],
		"Attributes": {
			"acl": "public-read",
			"name": "example-bucket",
			"region": "nyc3",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
