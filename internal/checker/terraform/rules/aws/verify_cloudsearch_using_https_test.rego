package lib.terraform.CB_TFAWS_211
import rego.v1

test_cloudsearch_using_https if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudsearch_domain",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "endpoint_options",
			"Labels": [],
			"Attributes": {"enforce_https": true},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudsearch_not_using_https if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudsearch_domain",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "endpoint_options",
			"Labels": [],
			"Attributes": {"enforce_https": false},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
