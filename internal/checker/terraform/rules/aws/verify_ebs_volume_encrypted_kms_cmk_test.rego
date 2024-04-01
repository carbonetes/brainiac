package lib.terraform.CB_TFAWS_196
import rego.v1

test_ebs_volume_encrypted_kms_cmk if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_replication_instance",
			"example",
		],
		"Attributes": {"kms_key_id": "kms"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ebs_volume_not_encrypted_kms_cmk if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_replication_instance",
			"example",
		],
		"Attributes": {"kms_key_id": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
