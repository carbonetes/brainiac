package lib.terraform.CB_TFAWS_283

import rego.v1 

test_verify_rds_postgress_sql_log_fwd_extenstion_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_db_instance",
				"pass"
			],
			"Attributes": {
				"engine": "aurora-postgresql",
				"engine_version": "11.9",
				"instance_class": "db.t3.micro",
				"name": "name"
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}

test_verify_rds_postgress_sql_log_fwd_extenstion_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_db_instance",
				"pass"
			],
			"Attributes": {
				"engine": "aurora-postgresql",
				"engine_version": "11.0",
				"instance_class": "db.t3.micro",
				"name": "name"
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}
