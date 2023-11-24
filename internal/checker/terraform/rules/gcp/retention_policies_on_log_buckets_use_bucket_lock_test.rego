package lib.terraform.CB_TFGCP_104

test_retention_policy_on_log_buckets_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_storage_bucket",
				"log_bucket_bad",
			],
			"Attributes": {"name": "organization-logging-bucket"},
			"Blocks": [
				{
					"Type": "retention_policy",
					"Labels": [],
					"Attributes": {
						"is_locked": true,
						"retention_period": "604800",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 4,
					},
				},
				{
					"Type": "logging",
					"Labels": [],
					"Attributes": {"log_bucket_name": "google_logging_folder_sink.folder_sink.destination"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				},
			],
			"line_range": {
				"endLine": 12,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_logging_folder_sink",
				"folder_sink",
			],
			"Attributes": {"name": "folder-sink"},
			"Blocks": [],
			"line_range": {
				"endLine": 16,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}

test_retention_policy_on_log_buckets_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_storage_bucket",
				"log_bucket_bad",
			],
			"Attributes": {"name": "organization-logging-bucket"},
			"Blocks": [
				{
					"Type": "retention_policy",
					"Labels": [],
					"Attributes": {
						"is_locked": false,
						"retention_period": "604800",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 4,
					},
				},
				{
					"Type": "logging",
					"Labels": [],
					"Attributes": {"log_bucket_name": "google_logging_folder_sink.folder_sink.destination"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				},
			],
			"line_range": {
				"endLine": 12,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_logging_folder_sink",
				"folder_sink",
			],
			"Attributes": {"name": "folder-sink"},
			"Blocks": [],
			"line_range": {
				"endLine": 16,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}
