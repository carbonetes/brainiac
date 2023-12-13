package lib.terraform.CB_TFALI_004

test_alicloud_actiontrail_trail_all_regions_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_actiontrail_trail",
			"pass",
		],
		"Attributes": {
			"event_rw": "All",
			"oss_bucket_name": "bucket_name",
			"oss_write_role_arn": "acs:ram::1182725xxxxxxxxxxx",
			"trail_name": "action-trail",
			"trail_region": "All",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_actiontrail_trail_all_regions_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_actiontrail_trail",
			"pass",
		],
		"Attributes": {
			"event_rw": "All",
			"oss_bucket_name": "bucket_name",
			"oss_write_role_arn": "acs:ram::1182725xxxxxxxxxxx",
			"trail_name": "action-trail",
			"trail_region": "",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
