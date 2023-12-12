package lib.docker.CB_DKR_010

test_workdir_values_are_absolute_paths {
	result := passed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": ["alpine:3.5"],
		},
		{
			"line_range": {
				"startLine": 2,
				"endLine": 2,
			},
			"instruction": "RUN",
			"args": [
				"apk",
				"add",
				"--update",
				"py2-pip",
			],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
			},
			"instruction": "RUN",
			"args": [
				"pip",
				"install",
				"--upgrade",
				"pip",
			],
		},
		{
			"line_range": {
				"startLine": 4,
				"endLine": 4,
			},
			"instruction": "WORKDIR",
			"args": ["$DIRPATH/$DIRNAME"],
		},
	]
	count(result) == 1
}

test_workdir_values_are_not_absolute_paths {
	result := failed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 1,
			},
			"instruction": "FROM",
			"args": ["alpine:3.5"],
		},
		{
			"line_range": {
				"startLine": 2,
				"endLine": 2,
			},
			"instruction": "RUN",
			"args": [
				"apk",
				"add",
				"--update",
				"py2-pip",
			],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
			},
			"instruction": "RUN",
			"args": [
				"pip",
				"install",
				"--upgrade",
				"pip",
			],
		},
		{
			"line_range": {
				"startLine": 4,
				"endLine": 4,
			},
			"instruction": "WORKDIR",
			"args": ["DIRPATH/$DIRNAME"],
		},
	]
	count(result) == 1
}
