package lib.terraform.CB_TFAWS_360

import rego.v1 

test_rds_instance_copy_tag_snapshots_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"default",
		],
		"Attributes": {
			"allocated_storage": "10",
			"copy_tags_to_snapshot": true,
			"db_name": "mydb",
			"engine": "mydb",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_rds_instance_copy_tag_snapshots_disabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"default",
		],
		"Attributes": {
			"allocated_storage": "10",
			"copy_tags_to_snapshot": false,
			"db_name": "mydb",
			"engine": "mydb",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
