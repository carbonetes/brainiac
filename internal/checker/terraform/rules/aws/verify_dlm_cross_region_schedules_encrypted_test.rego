package lib.terraform.CB_TFAWS_237
import rego.v1

test_dlm_cross_region_shedule_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dlm_lifecycle_policy",
			"pass",
		],
		"Attributes": {
			"description": "example DLM lifecycle policy",
			"execution_role_arn": "aws_iam_role.dlm_lifecycle_role.arn",
			"state": "ENABLED",
			"tags": {"test": "failed"},
		},
		"Blocks": [{
			"Type": "policy_details",
			"Labels": [],
			"Attributes": {
				"resource_types": ["VOLUME"],
				"target_tags": {"Snapshot": "true"},
			},
			"Blocks": [{
				"Type": "schedule",
				"Labels": [],
				"Attributes": {
					"copy_tags": false,
					"name": "2 weeks of daily snapshots",
					"tags_to_add": {"SnapshotCreator": "DLM"},
				},
				"Blocks": [
					{
						"Type": "create_rule",
						"Labels": [],
						"Attributes": {
							"interval": "24",
							"interval_unit": "HOURS",
							"times": ["23:45"],
						},
						"Blocks": [],
						"line_range": {
							"endLine": 16,
							"startLine": 12,
						},
					},
					{
						"Type": "retain_rule",
						"Labels": [],
						"Attributes": {"count": "14"},
						"Blocks": [],
						"line_range": {
							"endLine": 20,
							"startLine": 18,
						},
					},
					{
						"Type": "cross_region_copy_rule",
						"Labels": [],
						"Attributes": {
							"cmk_arn": "aws_kms_key.dlm_cross_region_copy_cmk.arn",
							"copy_tags": true,
							"encrypted": true,
							"target": "us-west-2",
						},
						"Blocks": [{
							"Type": "retain_rule",
							"Labels": [],
							"Attributes": {
								"interval": "30",
								"interval_unit": "DAYS",
							},
							"Blocks": [],
							"line_range": {
								"endLine": 36,
								"startLine": 33,
							},
						}],
						"line_range": {
							"endLine": 37,
							"startLine": 28,
						},
					},
				],
				"line_range": {
					"endLine": 38,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 43,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 47,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_dlm_cross_region_schedules_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dlm_lifecycle_policy",
			"pass",
		],
		"Attributes": {
			"description": "example DLM lifecycle policy",
			"execution_role_arn": "aws_iam_role.dlm_lifecycle_role.arn",
			"state": "ENABLED",
			"tags": {"test": "failed"},
		},
		"Blocks": [{
			"Type": "policy_details",
			"Labels": [],
			"Attributes": {
				"resource_types": ["VOLUME"],
				"target_tags": {"Snapshot": "true"},
			},
			"Blocks": [{
				"Type": "schedule",
				"Labels": [],
				"Attributes": {
					"copy_tags": false,
					"name": "2 weeks of daily snapshots",
					"tags_to_add": {"SnapshotCreator": "DLM"},
				},
				"Blocks": [
					{
						"Type": "create_rule",
						"Labels": [],
						"Attributes": {
							"interval": "24",
							"interval_unit": "HOURS",
							"times": ["23:45"],
						},
						"Blocks": [],
						"line_range": {
							"endLine": 16,
							"startLine": 12,
						},
					},
					{
						"Type": "retain_rule",
						"Labels": [],
						"Attributes": {"count": "14"},
						"Blocks": [],
						"line_range": {
							"endLine": 20,
							"startLine": 18,
						},
					},
					{
						"Type": "cross_region_copy_rule",
						"Labels": [],
						"Attributes": {
							"cmk_arn": "aws_kms_key.dlm_cross_region_copy_cmk.arn",
							"copy_tags": true,
							"encrypted": false,
							"target": "us-west-2",
						},
						"Blocks": [{
							"Type": "retain_rule",
							"Labels": [],
							"Attributes": {
								"interval": "30",
								"interval_unit": "DAYS",
							},
							"Blocks": [],
							"line_range": {
								"endLine": 36,
								"startLine": 33,
							},
						}],
						"line_range": {
							"endLine": 37,
							"startLine": 28,
						},
					},
				],
				"line_range": {
					"endLine": 38,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 43,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 47,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
