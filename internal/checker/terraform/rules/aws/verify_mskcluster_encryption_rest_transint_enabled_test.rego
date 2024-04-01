package lib.terraform.CB_TFAWS_093
import rego.v1

test_mskcluster_enrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_msk_cluster",
			"example",
		],
		"Attributes": {"cluster_name": "example"},
		"Blocks": [{
			"Type": "encryption_info",
			"Labels": [],
			"Attributes": {"encryption_at_rest_kms_key_arn": "aws_kms_key.kms.arn"},
			"Blocks": [{
				"Type": "encryption_in_transit",
				"Labels": [],
				"Attributes": {
					"client_broker": "TLS",
					"in_cluster": true,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_mskcluster_not_enrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_msk_cluster",
			"example",
		],
		"Attributes": {"cluster_name": "example"},
		"Blocks": [{
			"Type": "encryption_info",
			"Labels": [],
			"Attributes": {"encryption_at_rest_kms_key_arn": "aws_kms_key.kms.arn"},
			"Blocks": [{
				"Type": "encryption_in_transit",
				"Labels": [],
				"Attributes": {
					"client_broker": "TLS",
					"in_cluster": false,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
