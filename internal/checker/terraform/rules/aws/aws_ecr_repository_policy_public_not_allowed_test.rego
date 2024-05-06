package lib.terraform.CB_TFAWS_029
import rego.v1

test_aws_ecr_repository_policy_public_not_allowed_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecr_repository_policy",
			"example",
		],
		"Attributes": {"policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": \"arn:aws:iam::123456789012:user/example-user\",\n      \"Action\": \"ecr:*\",\n      \"Resource\": \"*\"\n    }\n  ]\n}\n"},
		"Blocks": [],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_ecr_repository_policy_public_not_allowed_faied if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecr_repository_policy",
			"example",
		],
		"Attributes": {"policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": \"*\",\n      \"Action\": \"ecr:*\",\n      \"Resource\": \"*\"\n    }\n  ]\n}\n"},
		"Blocks": [],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
