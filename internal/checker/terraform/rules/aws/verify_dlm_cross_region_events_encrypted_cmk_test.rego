package lib.terraform.CB_TFAWS_236
import rego.v1

test_dlm_cross_region_events_encrypted_using_cmk if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dlm_lifecycle_policy",
			"pass",
		],
		"Attributes": {
			"description": "tf-acc-basic",
			"execution_role_arn": "aws_iam_role.example.arn",
		},
		"Blocks": [{
			"Type": "policy_details",
			"Labels": [],
			"Attributes": {"policy_type": "EVENT_BASED_POLICY"},
			"Blocks": [{
				"Type": "action",
				"Labels": [],
				"Attributes": {"name": "tf-acc-basic"},
				"Blocks": [{
					"Type": "cross_region_copy",
					"Labels": [],
					"Attributes": {},
					"Blocks": [
						{
							"Type": "encryption_configuration",
							"Labels": [],
							"Attributes": {
								"cmk_arn": "aws_kms_key.test.arn",
								"encryption": true,
							},
							"Blocks": [],
							"line_range": {
								"endLine": 17,
								"startLine": 14,
							},
						},
						{
							"Type": "retain_rule",
							"Labels": [],
							"Attributes": {
								"interval": "15",
								"interval_unit": "MONTHS",
							},
							"Blocks": [],
							"line_range": {
								"endLine": 21,
								"startLine": 18,
							},
						},
					],
					"line_range": {
						"endLine": 23,
						"startLine": 13,
					},
				}],
				"line_range": {
					"endLine": 24,
					"startLine": 11,
				},
			}],
			"line_range": {
				"endLine": 25,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 26,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_dlm_cross_region_events_encrypted_not_cmk if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dlm_lifecycle_policy",
			"pass",
		],
		"Attributes": {
			"description": "tf-acc-basic",
			"execution_role_arn": "aws_iam_role.example.arn",
		},
		"Blocks": [{
			"Type": "policy_details",
			"Labels": [],
			"Attributes": {"policy_type": "EVENT_BASED_POLICY"},
			"Blocks": [{
				"Type": "action",
				"Labels": [],
				"Attributes": {"name": "tf-acc-basic"},
				"Blocks": [{
					"Type": "cross_region_copy",
					"Labels": [],
					"Attributes": {},
					"Blocks": [
						{
							"Type": "encryption_configuration",
							"Labels": [],
							"Attributes": {
								"encryption": false,
							},
							"Blocks": [],
							"line_range": {
								"endLine": 17,
								"startLine": 14,
							},
						},
						{
							"Type": "retain_rule",
							"Labels": [],
							"Attributes": {
								"interval": "15",
								"interval_unit": "MONTHS",
							},
							"Blocks": [],
							"line_range": {
								"endLine": 21,
								"startLine": 18,
							},
						},
					],
					"line_range": {
						"endLine": 23,
						"startLine": 13,
					},
				}],
				"line_range": {
					"endLine": 24,
					"startLine": 11,
				},
			}],
			"line_range": {
				"endLine": 25,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 26,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
