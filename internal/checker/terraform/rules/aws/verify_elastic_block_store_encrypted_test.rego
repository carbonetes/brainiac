package lib.terraform.CB_TFAWS_007
import rego.v1

test_elasticsearch_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_instance",
			"example",
		],
		"Attributes": {
			"domain_name": "example-domain",
			"elasticsearch_version": "7.10",
		},
		"Blocks": [{
			"Type": "root_block_device",
			"Labels": [],
			"Attributes": {"encrypted": true},
			"Blocks": [],
			"line_range": {
				"endLine": 75,
				"startLine": 73,
			},
		}],
		"line_range": {
			"endLine": 78,
			"startLine": 69,
		},
	}]
	count(result) == 1
}

test_elasticsearch_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_launch_configuration",
			"example",
		],
		"Attributes": {
			"domain_name": "example-domain",
			"elasticsearch_version": "7.10",
		},
		"Blocks": [{
			"Type": "root_block_device",
			"Labels": [],
			"Attributes": {"encrypted": false},
			"Blocks": [],
			"line_range": {
				"endLine": 75,
				"startLine": 73,
			},
		}],
		"line_range": {
			"endLine": 78,
			"startLine": 69,
		},
	}]
	count(result) == 1
}
