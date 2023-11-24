package lib.terraform.CB_TFGCP_093

test_vertex_ai_instances_are_private {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_notebooks_instance",
			"public_instance",
		],
		"Attributes": {
			"name": "my-notebook",
			"no_public_ip": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_vertex_ai_instances_are_not_private {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_notebooks_instance",
			"public_instance",
		],
		"Attributes": {
			"name": "my-notebook",
			"no_public_ip": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
