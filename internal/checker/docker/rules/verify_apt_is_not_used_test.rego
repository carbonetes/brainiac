package lib.docker.CB_DKR_009

test_apt_is_not_used {
	result := passed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": ["busybox:1.0"],
		},
		{
			"line_range": {
				"startLine": 2,
				"endLine": 2,
			},
			"instruction": "RUN",
			"args": [
				"install",
				"curl",
			],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
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
	]
	count(result) == 1
}

test_apt_is_used {
	result := failed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": ["busybox:1.0"],
		},
		{
			"line_range": {
				"startLine": 2,
				"endLine": 2,
			},
			"instruction": "RUN",
			"args": [
				"apt",
				"get",
				"install",
				"curl",
			],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
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
	]
	count(result) == 1
}
