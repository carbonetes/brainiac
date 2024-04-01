package lib.terraform.CB_TFAWS_131
import rego.v1

test_mskcluster_logging_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster",
			"test",
		],
		"Attributes": {"backup_retention_period": "30"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_mskcluster_logging_enabled_false if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster",
			"test",
		],
		"Attributes": {"backup_retention_period": "0"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
