package lib.terraform.CB_TFAWS_358

import rego.v1 

test_aws_neptune_cluse_deletion_protected if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster",
			"default",
		],
		"Attributes": {"deletion_protection": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_neptune_cluse_deletion_protected_disabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster",
			"default",
		],
		"Attributes": {"deletion_protection": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
