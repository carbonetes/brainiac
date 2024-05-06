package lib.terraform.CB_TFAWS_114
import rego.v1

test_api_gateway_caching_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_stage",
			"example",
		],
		"Attributes": {
			"cache_cluster_enabled": true,
			"cache_cluster_size": "0.5",
			"rest_api_id": "aws_api_gateway_rest_api.example.id",
			"stage_name": "dev",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_api_gateway_caching_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_stage",
			"example",
		],
		"Attributes": {
			"cache_cluster_enabled": false,
			"cache_cluster_size": "0.5",
			"rest_api_id": "aws_api_gateway_rest_api.example.id",
			"stage_name": "dev",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
