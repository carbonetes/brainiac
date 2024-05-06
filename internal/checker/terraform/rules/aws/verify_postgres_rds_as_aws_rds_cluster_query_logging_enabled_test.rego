package lib.terraform.CB_TFAWS_322

import rego.v1 

test_aws_rds_query_logging_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster_parameter_group",
			"examplea",
		],
		"Attributes": {
			"family": "postgres10",
			"name": "rds-cluster-pg",
		},
		"Blocks": [
			{
				"Type": "parameter",
				"Labels": [],
				"Attributes": {
					"name": "log_statement",
					"value": "all",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 5,
				},
			},
			{
				"Type": "parameter",
				"Labels": [],
				"Attributes": {
					"name": "log_min_duration_statement",
					"value": "1",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 13,
					"startLine": 10,
				},
			},
		],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_rds_query_logging_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster_parameter_group",
			"examplea",
		],
		"Attributes": {
			"family": "postgres10",
			"name": "rds-cluster-pg",
		},
		"Blocks": [{
			"Type": "parameter",
			"Labels": [],
			"Attributes": {
				"name": "log_statement",
				"value": "all",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
