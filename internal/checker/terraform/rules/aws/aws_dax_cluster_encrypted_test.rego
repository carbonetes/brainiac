package lib.terraform.CB_TFAWS_041
import rego.v1

test_aws_dax_cluster_encrypted_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dax_cluster",
			"example",
		],
		"Attributes": {
			"cluster_name": "example-dax-cluster",
			"node_type": "dax.r4.large",
			"replication_factor": "2",
		},
		"Blocks": [{
			"Type": "server_side_encryption",
			"Labels": [],
			"Attributes": {"enabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_dax_cluster_encrypted_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dax_cluster",
			"example",
		],
		"Attributes": {
			"cluster_name": "example-dax-cluster",
			"node_type": "dax.r4.large",
			"replication_factor": "2",
		},
		"Blocks": [{
			"Type": "server_side_encryption",
			"Labels": [],
			"Attributes": {"enabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
