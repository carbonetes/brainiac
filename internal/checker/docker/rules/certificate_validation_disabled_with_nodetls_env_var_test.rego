package lib.docker.CB_DKR_017

test_certificate_validation_disabled_with_nodetls_env {
	result := passed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 2,
			},
			"instruction": "FROM",
			"args": ["python:3.9"],
		},
		{
			"line_range": {
				"startLine": 4,
				"endLine": 7,
			},
			"instruction": "ENV",
			"args": [],
		},
	]
	count(result) == 1
}

test_certificate_validation_not_disabled_with_nodetls_env {
	result := failed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 2,
			},
			"instruction": "FROM",
			"args": ["python:3.9"],
		},
		{
			"line_range": {
				"startLine": 4,
				"endLine": 7,
			},
			"instruction": "ENV",
			"args": ["NODE_TLS_REJECT_UNAUTHORIZED=0"],
		},
	]
	count(result) == 1
}
