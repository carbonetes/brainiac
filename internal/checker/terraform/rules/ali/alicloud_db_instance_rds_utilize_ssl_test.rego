package lib.terraform.CB_TFALI_029

test_alicloud_db_instance_rds_utilize_ssl_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_db_instance",
			"pass",
		],
		"Attributes": {
			"engine": "MySQL",
			"engine_version": "5.6",
			"instance_storage": "30",
			"instance_type": "mysql.n2.small.25",
			"parameters": [
				{
					"name": "innodb_large_prefix",
					"value": "ON",
				},
				{
					"name": "connect_timeout",
					"value": "50",
				},
			],
			"ssl_action": "Open",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_db_instance_rds_utilize_ssl_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_db_instance",
			"pass",
		],
		"Attributes": {
			"engine": "MySQL",
			"engine_version": "5.6",
			"instance_storage": "30",
			"instance_type": "mysql.n2.small.25",
			"parameters": [
				{
					"name": "innodb_large_prefix",
					"value": "ON",
				},
				{
					"name": "connect_timeout",
					"value": "50",
				},
			],
			"ssl_action": "",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
