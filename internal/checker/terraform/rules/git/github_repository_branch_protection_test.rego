package lib.terraform.CB_TFGIT_007

test_github_repository_branch_protection_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"github_repository",
				"example_repo",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"github_branch_protection",
				"example_protection",
			],
			"Attributes": {"repository": "github_repository.example_repo.name"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"github_branch_protection_v3",
				"example_protection",
			],
			"Attributes": {"repository": "github_repository.example_repo.name"},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 10,
			},
		},
	]
	count(result) == 1
}

test_github_repository_branch_protection_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"github_repository",
				"example_repo",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"github_branch_protection",
				"example_protection",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"github_branch_protection_v3",
				"example_protection",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 10,
			},
		},
	]
	count(result) == 1
}
