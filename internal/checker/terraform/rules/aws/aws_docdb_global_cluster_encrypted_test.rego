package lib.terraform.CB_TFAWS_269

import rego.v1 

test_aws_docdb_global_cluster_encrypted_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_docdb_global_cluster",
			"example",
		],
		"Attributes": {
			"engine": "docdb",
			"global_cluster_identifier": "my-global-cluster",
			"source_region": "us-west-2",
			"storage_encrypted": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_docdb_global_cluster_encrypted_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_docdb_global_cluster",
			"example",
		],
		"Attributes": {
			"engine": "docdb",
			"global_cluster_identifier": "my-global-cluster",
			"source_region": "us-west-2",
			"storage_encrypted": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
