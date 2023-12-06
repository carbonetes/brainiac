package lib.docker.CB_DKR_006

test_label_is_used_instead_of_mantainer {
	result := passed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 2,
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
			"args": ["maintainer"],
		},
	]
	count(result) == 1
}

test_maintainer_is_used {
	result := failed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 2,
			},
			"instruction": "FROM",
			"args": ["base"],
		},
		{
			"line_range": {
				"startLine": 3,
				"endLine": 3,
			},
			"instruction": "MAINTAINER",
			"args": ["carbonetes"],
		},
	]
	count(result) == 1
}
