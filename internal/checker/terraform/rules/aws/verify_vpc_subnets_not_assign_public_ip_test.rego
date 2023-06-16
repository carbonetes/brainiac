package lib.terraform.CB_TFAWS_128

test_vpc_subnets_not_assign_public_ip_default {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_subnet",
			"test",
		],
		"Attributes": {"map_public_ip_on_launch": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_vpc_subnets_assign_public_ip_default {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_subnet",
			"test",
		],
		"Attributes": {"map_public_ip_on_launch": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
