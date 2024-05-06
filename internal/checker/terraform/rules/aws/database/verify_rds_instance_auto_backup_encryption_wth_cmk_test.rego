package lib.terraform.CB_TFAWS_274

import rego.v1 

test_verify_rds_instance_auto_backup_encryption_wth_cmk_test_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance_automated_backups_replication",
			"default"
		],
		"Attributes": {
			"kms_key_id": "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
		},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1
		}
	}]
	count(result) == 1
}

test_verify_rds_instance_auto_backup_encryption_wth_cmk_test_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance_automated_backups_replication",
			"default"
		],
		"Attributes": {
			"kms_key_id": ""
		},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1
		}
	}]
	count(result) == 1
}
