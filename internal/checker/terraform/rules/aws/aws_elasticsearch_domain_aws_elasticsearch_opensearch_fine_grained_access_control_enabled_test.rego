package lib.terraform.CB_TFAWS_353

import rego.v1 

test_aws_elasticsearch_domain_aws_elasticsearch_opensearch_fine_grained_access_control_enabled_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elasticsearch_domain",
			"example",
		],
		"Attributes": {
			"domain_name": "example-domain",
			"elasticsearch_version": "7.10",
		},
		"Blocks": [{
			"Type": "advanced_security_options",
			"Labels": [],
			"Attributes": {
				"enabled": true,
				"internal_user_database_enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_elasticsearch_domain_aws_elasticsearch_opensearch_fine_grained_access_control_enabled_disabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elasticsearch_domain",
			"example",
		],
		"Attributes": {
			"domain_name": "example-domain",
			"elasticsearch_version": "7.10",
		},
		"Blocks": [{
			"Type": "advanced_security_options",
			"Labels": [],
			"Attributes": {
				"enabled": false,
				"internal_user_database_enabled": false,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
