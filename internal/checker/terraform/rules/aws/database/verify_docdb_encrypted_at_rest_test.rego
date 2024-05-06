package lib.terraform.CB_TFAWS_083
import rego.v1

test_docdb_encrypted_at_rest if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_docdb_cluster",
			"example",
		],
		"Attributes": {
			"cluster_identifier": "docdb-cluster-demo",
			"storage_encrypted": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_docdb_not_encrypted_at_rest if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_docdb_cluster",
			"example",
		],
		"Attributes": {
			"cluster_identifier": "docdb-cluster-demo",
			"storage_encrypted": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
