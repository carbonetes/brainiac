package lib.terraform.CB_TFAWS_086
import rego.v1

test_codebuild_project_enryption_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codebuild_project",
			"project-with-cache",
		],
		"Attributes": {"name": "test-project-cache"},
		"Blocks": [{
			"Type": "artifacts",
			"Labels": [],
			"Attributes": {"encryption_disabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_codebuild_project_enryption_disabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codebuild_project",
			"project-with-cache",
		],
		"Attributes": {"name": "test-project-cache"},
		"Blocks": [{
			"Type": "artifacts",
			"Labels": [],
			"Attributes": {"encryption_disabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
