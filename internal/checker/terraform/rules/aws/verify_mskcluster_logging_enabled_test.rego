package lib.terraform.CB_TFAWS_091
import rego.v1

test_mskcluster_logging_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_msk_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logging_info",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "broker_logs",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "cloudwatch_logs",
					"Labels": [],
					"Attributes": {"enabled": true},
					"Blocks": [],
					"line_range": {
						"endLine": 6,
						"startLine": 4,
					},
				}],
				"line_range": {
					"endLine": 7,
					"startLine": 3,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_mskcluster_logging_enabled_false if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_msk_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logging_info",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "broker_logs",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "cloudwatch_logs",
					"Labels": [],
					"Attributes": {"enabled": false},
					"Blocks": [],
					"line_range": {
						"endLine": 6,
						"startLine": 4,
					},
				}],
				"line_range": {
					"endLine": 7,
					"startLine": 3,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
