package lib.terraform.CB_TFAWS_109

test_amazon_rds_monitoring_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"default",
		],
		"Attributes": {
			"allocated_storage": "10",
			"monitoring_interval": "5",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_amazon_rds_monitoring_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"default",
		],
		"Attributes": {"allocated_storage": "10"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
