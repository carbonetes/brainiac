package lib.terraform.CB_TFAWS_280

import rego.v1 

test_db_snapshot_not_public if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_snapshot",
			"example_db_snapshot",
		],
		"Attributes": {
			"db_instance_identifier": "aws_db_instance.example_db_instance.id",
			"db_snapshot_identifier": "example-db-snapshot",
			"shared_accounts": "",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_db_snapshot_public if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_snapshot",
			"example_db_snapshot",
		],
		"Attributes": {
			"db_instance_identifier": "aws_db_instance.example_db_instance.id",
			"db_snapshot_identifier": "example-db-snapshot",
			"shared_accounts": "all",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
