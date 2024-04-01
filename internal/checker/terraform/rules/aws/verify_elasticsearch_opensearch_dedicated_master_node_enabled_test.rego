package lib.terraform.CB_TFAWS_359

import rego.v1 

test_elasticsearch_dedicated_master_node_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elasticsearch_domain",
			"es",
		],
		"Attributes": {
			"domain_name": "var.domain",
			"elasticsearch_version": "6.3",
		},
		"Blocks": [{
			"Type": "cluster_config",
			"Labels": [],
			"Attributes": {
				"dedicated_master_enabled": true,
				"instance_type": "m4.large.elasticsearch",
				"zone_awareness_enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_elasticsearch_dedicated_master_node_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elasticsearch_domain",
			"es",
		],
		"Attributes": {
			"domain_name": "var.domain",
			"elasticsearch_version": "6.3",
		},
		"Blocks": [{
			"Type": "cluster_config",
			"Labels": [],
			"Attributes": {
				"dedicated_master_enabled": false,
				"instance_type": "m4.large.elasticsearch",
				"zone_awareness_enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
