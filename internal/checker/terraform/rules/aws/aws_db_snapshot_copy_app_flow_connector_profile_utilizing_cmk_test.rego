package lib.terraform.CB_TFAWS_241
import rego.v1

test_aws_db_snapshot_copy_app_flow_connector_profile_utilizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_snapshot_copy",
			"pass",
		],
		"Attributes": {
			"kms_key_id": "aws_kms_key.example.id",
			"source_db_snapshot_identifier": "aws_db_snapshot.example.db_snapshot_arn",
			"target_db_snapshot_identifier": "testsnapshot1234-copy",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_db_snapshot_copy_app_flow_connector_profile_utilizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_snapshot_copy",
			"pass",
		],
		"Attributes": {
			"kms_key_id": "",
			"source_db_snapshot_identifier": "aws_db_snapshot.example.db_snapshot_arn",
			"target_db_snapshot_identifier": "testsnapshot1234-copy",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
