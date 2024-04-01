package lib.terraform.CB_TFAWS_210
import rego.v1

test_code_pipeline_artifact_store_using_kms if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codepipeline",
			"pass",
		],
		"Attributes": {
			"name": "tf-test-pipeline",
			"role_arn": "aws_iam_role.codepipeline_role.arn",
		},
		"Blocks": [{
			"Type": "artifact_store",
			"Labels": [],
			"Attributes": {
				"location": "aws_s3_bucket.codepipeline_bucket.bucket",
				"type": "S3",
			},
			"Blocks": [{
				"Type": "encryption_key",
				"Labels": [],
				"Attributes": {
					"id": "data.aws_kms_alias.s3kmskey.arn",
					"type": "KMS",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_code_pipeline_artifact_store_not_using_kms if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codepipeline",
			"pass",
		],
		"Attributes": {
			"name": "tf-test-pipeline",
			"role_arn": "aws_iam_role.codepipeline_role.arn",
		},
		"Blocks": [{
			"Type": "artifact_store",
			"Labels": [],
			"Attributes": {
				"location": "aws_s3_bucket.codepipeline_bucket.bucket",
				"type": "S3",
			},
			"Blocks": [{
				"Type": "encryption_key",
				"Labels": [],
				"Attributes": {"type": "KMS"},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
