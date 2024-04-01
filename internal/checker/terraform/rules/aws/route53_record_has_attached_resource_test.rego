package lib.terraform.CB_TFAWS_319

import rego.v1

test_route53_a_record_has_attached_resource if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_route53_record",
			"www",
		],
		"Attributes": {
			"name": "example.com",
			"type": "A",
			"zone_id": "aws_route53_zone.primary.zone_id",
		},
		"Blocks": [{
			"Type": "alias",
			"Labels": [],
			"Attributes": {
				"evaluate_target_health": true,
				"name": "data.example.com",
				"zone_id": "aws_elb.main.zone_id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_route53_a_record_has_no_attached_resource if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_route53_record",
			"www",
		],
		"Attributes": {
			"name": "example.com",
			"type": "A",
			"zone_id": "aws_route53_zone.primary.zone_id",
		},
		"Blocks": [{
			"Type": "alias",
			"Labels": [],
			"Attributes": {
				"evaluate_target_health": true,
				"name": "mod.example.com",
				"zone_id": "aws_elb.main.zone_id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
