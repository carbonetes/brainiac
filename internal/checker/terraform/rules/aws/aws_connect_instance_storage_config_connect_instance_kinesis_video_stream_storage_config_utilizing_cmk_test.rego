package lib.terraform.CB_TFAWS_244

test_aws_connect_instance_storage_config_connect_instance_kinesis_video_stream_storage_config_utilizing_cmk_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_connect_instance_storage_config",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "storage_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "kinesis_video_stream_config",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "encryption_config",
					"Labels": [],
					"Attributes": {"key_id": "key_id"},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 5,
					},
				}],
				"line_range": {
					"endLine": 8,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_connect_instance_storage_config_connect_instance_kinesis_video_stream_storage_config_utilizing_cmk_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_connect_instance_storage_config",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "storage_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "kinesis_video_stream_config",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "encryption_config",
					"Labels": [],
					"Attributes": {"key_id": ""},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 5,
					},
				}],
				"line_range": {
					"endLine": 8,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
