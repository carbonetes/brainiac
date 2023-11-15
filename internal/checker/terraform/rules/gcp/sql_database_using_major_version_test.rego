package lib.terraform.CB_TFGCP_076

test_sql_database_using_the_latest_major_version {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"pass",
		],
		"Attributes": {
			"database_version": "MYSQL_8_0",
			"name": "private-instance-",
			"provider": "google",
			"region": "us-central1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_sql_database_not_using_the_latest_major_version {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"pass",
		],
		"Attributes": {
			"database_version": "MYSQL_5_0",
			"name": "private-instance-",
			"provider": "google",
			"region": "us-central1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
