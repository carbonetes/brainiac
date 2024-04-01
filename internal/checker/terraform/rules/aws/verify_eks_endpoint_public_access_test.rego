package lib.terraform.CB_TFAWS_045
import rego.v1

test_eks_endpoint_public_access_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_eks_cluster",
			"example",
		],
		"Attributes": {"name": "example-cluster"},
		"Blocks": [{
			"Type": "vpc_config",
			"Labels": [],
			"Attributes": {
				"endpoint_public_access": false,
				"endpoint_public_access_cidrs": ["1.0.0.0/0"],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_eks_endpoint_public_access_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_eks_cluster",
			"example",
		],
		"Attributes": {"name": "example-cluster"},
		"Blocks": [{
			"Type": "vpc_config",
			"Labels": [],
			"Attributes": {
				"endpoint_public_access": true,
				"endpoint_public_access_cidrs": ["1.0.0.0/0"],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
