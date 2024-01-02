package lib.docker.CB_DKR_004

test_copy_is_used_instead_of_add {
	result := passed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": ["base"],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
			},
			"instruction": "LABEL",
			"args": [
				"foo=\"bar",
				"baz\"",
			],
		},
		{
			"line_range": {
				"startLine": 4,
				"endLine": 4,
			},
			"instruction": "USER",
			"args": ["me"],
		},
		{
			"line_range": {
				"startLine": 5,
				"endLine": 5,
			},
			"instruction": "HEALTHCHECK",
			"args": [
				"CMD",
				"curl",
				"--fail",
				"http://localhost:3000",
				"||",
				"exit",
				"1",
			],
		},
        {
			"line_range": {
				"startLine": 5,
				"endLine": 5,
			},
			"instruction": "COPY",
			"args": [
				"--from=builder",
				"application/dependencies/",
				"./",
			],
		},
	]
	count(result) == 1
}

test_add_is_used_instead_of_copy {
	result := failed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": ["base"],
		},
		{
			"line_range": {
				"startLine": 5,
				"endLine": 5,
			},
			"instruction": "ADD",
			"args": [
				"--from=builder",
				"application/dependencies/",
				"./",
			],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
			},
			"instruction": "LABEL",
			"args": [
				"foo=\"bar",
				"baz\"",
			],
		},
	]
	count(result) == 1
}
