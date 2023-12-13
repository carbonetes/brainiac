package lib.terraform.CB_TFALI_013

test_alicloud_db_instance_db_instance_public_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_db_instance",
			"pass",
		],
		"Attributes": {
			"db_instance_class": "rds.mysql.t1.small",
			"db_instance_storage": "10",
			"engine": "MySQL",
			"engine_version": "5.6",
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
			"security_ips": ["10.23.12.24"],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_db_instance_db_instance_public_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_db_instance",
			"pass",
		],
		"Attributes": {
			"db_instance_class": "rds.mysql.t1.small",
			"db_instance_storage": "10",
			"engine": "MySQL",
			"engine_version": "5.6",
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
			"security_ips": ["0.0.0.0"],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
