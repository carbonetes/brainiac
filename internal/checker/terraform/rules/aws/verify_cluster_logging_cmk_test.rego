package lib.terraform.CB_TFAWS_217
import rego.v1

test_cluster_logging_cmk if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecs_cluster",
			"pass2",
		],
		"Attributes": {
			"name": "white-hart",
			"tags": {"test": "fail"},
		},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "execute_command_configuration",
				"Labels": [],
				"Attributes": {
					"kms_key_id": "aws_kms_key.example.arn",
					"logging": "",
				},
				"Blocks": [{
					"Type": "log_configuration",
					"Labels": [],
					"Attributes": {
						"cloud_watch_encryption_enabled": true,
						"s3_bucket_encryption_enabled": true
						},
					"Blocks": [],
					"line_range": {
						"endLine": 9,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 10,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cluster_logging_not_cmk if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecs_cluster",
			"pass2",
		],
		"Attributes": {
			"name": "white-hart",
			"tags": {"test": "fail"},
		},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "execute_command_configuration",
				"Labels": [],
				"Attributes": {
					"kms_key_id": "aws_kms_key.example.arn",
					"logging": "",
				},
				"Blocks": [{
					"Type": "log_configuration",
					"Labels": [],
					"Attributes": {
						"cloud_watch_encryption_enabled": false,
						"s3_bucket_encryption_enabled": false
						},
					"Blocks": [],
					"line_range": {
						"endLine": 9,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 10,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
