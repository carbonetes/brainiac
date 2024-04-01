package lib.terraform.CB_TFAWS_262

import rego.v1 

test_aws_neptune_cluster_snapshot_neptune_snapshot_encrypted_by_kms_utilizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster_snapshot",
			"example",
		],
		"Attributes": {"kms_key_id": "any"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_neptune_cluster_snapshot_neptune_snapshot_encrypted_by_kms_utilizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster_snapshot",
			"example",
		],
		"Attributes": {"kms_key_id": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
