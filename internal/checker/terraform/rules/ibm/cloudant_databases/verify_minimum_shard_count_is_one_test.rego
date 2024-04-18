package lib.terraform.CB_TFIBM_064
import rego.v1

test_shards_minimum_count_pass if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_cloudant_database",
			"cloudant_database",
		],
		"Attributes": {
			"db": "var.db_name",
			"instance_crn": "var.instance_crn",
			"partitioned": false,
			"shards": 1,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_shards_minimum_count_fail if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_cloudant_database",
			"cloudant_database",
		],
		"Attributes": {
			"db": "var.db_name",
			"instance_crn": "var.instance_crn",
			"partitioned": true,
			"shards": 0,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
