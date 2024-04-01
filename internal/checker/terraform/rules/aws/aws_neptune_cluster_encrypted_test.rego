package lib.terraform.CB_TFAWS_025
import rego.v1

test_aws_neptune_cluster_encrypted_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster",
			"example",
		],
		"Attributes": {
			"cluster_identifier": "example-cluster",
			"storage_encrypted": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_neptune_cluster_encrypted_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster",
			"example",
		],
		"Attributes": {
			"cluster_identifier": "example-cluster",
			"storage_encrypted": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
