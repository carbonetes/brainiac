package lib.docker.CB_DKR_007

test_base_image_have_version_tag {
	result := passed with input as [
		{
			"line_range": {
				"startLine": 1,
				"endLine": 2,
			},
			"instruction": "FROM",
			"args": ["base:test"],
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

test_base_image_have_no_version_tag {
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
