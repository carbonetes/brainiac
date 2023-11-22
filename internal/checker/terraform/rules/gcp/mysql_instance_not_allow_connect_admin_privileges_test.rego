package lib.terraform.CB_TFGCP_106

test_database_instance_not_allwed_to_connect_admin_privileges {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_sql_database_instance",
				"example_instance",
			],
			"Attributes": {
				"database_version": "MYSQL_5_7",
				"name": "example-instance",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_sql_user",
				"restricted_user",
			],
			"Attributes": {
				"instance": "google_sql_database_instance.example_instance.name",
				"name": "restricted_user",
				"password": "user-password",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

test_database_instance_not_allwed_to_connect_admin_privileges_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_sql_database_instance",
				"example_instance",
			],
			"Attributes": {
				"database_version": "MYSQL_5_7",
				"name": "example-instance",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_sql_user",
				"restricted_user",
			],
			"Attributes": {
				"instance": "google_sql_database_instance.example_instance.name",
				"name": "rootr",
				"password": "user-password",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}
