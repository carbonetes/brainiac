package lib.terraform.CB_TFAWS_035
import rego.v1

test_eks_public_access_cidr_endpoint_public_access_passed if {
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

test_eks_public_access_cidr_endpoint_public_access_failed if {
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

test_eks_public_access_cidr_public_access_cidrs_passed if {
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
			"Attributes": {"public_access_cidrs": ["1.0.0.0/0"]},
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

test_eks_public_access_cidr_public_access_cidrs_failed if {
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
			"Attributes": {"public_access_cidrs": ["0.0.0.0/0"]},
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
