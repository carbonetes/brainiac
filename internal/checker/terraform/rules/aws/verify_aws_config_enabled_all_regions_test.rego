package lib.terraform.CB_TFAWS_116
import rego.v1

test_aws_config_config_enabled_all_regions if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_config_configuration_aggregator",
			"example",
		],
		"Attributes": {"name": "example-aggregator"},
		"Blocks": [{
			"Type": "account_aggregation_source",
			"Labels": [],
			"Attributes": {"all_regions": true},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_config_config_not_enabled_all_regions if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_config_configuration_aggregator",
			"example",
		],
		"Attributes": {"name": "example-aggregator"},
		"Blocks": [{
			"Type": "account_aggregation_source",
			"Labels": [],
			"Attributes": {"all_regions": false},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
