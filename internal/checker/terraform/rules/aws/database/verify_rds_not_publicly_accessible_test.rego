package lib.terraform.CB_TFAWS_021
import rego.v1 

test_rds_publicly_available if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"example",
		],
		"Attributes": {
			"storage_type": "gp2",
			"username": "example",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_rds_publicly_not_available if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster_instance",
			"example",
		],
		"Attributes": {
			"publicly_accessible": true,
			"storage_type": "gp2",
			"username": "example",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
