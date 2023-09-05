package lib.terraform.CB_TFAWS_049

test_ecr_image_tag_is_immutable {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecr_repository",
			"example",
		],
		"Attributes": {
			"image_tag_mutability": "IMMUTABLE",
			"name": "bar",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ecr_image_tag_is_not_immutable {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecr_repository",
			"example",
		],
		"Attributes": {"name": "bar"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
