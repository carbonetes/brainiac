package lib.terraform.CB_TFAWS_279

test_verify_elesticsearch_default_security_group_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_elasticsearch_domain",
				"pass"
			],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "vpc_options",
					"Labels": [],
					"Attributes": {
						"security_group_ids": [
							"sg_1234545"
						]
					},
					"Blocks": [],
					"line_range": {
						"endLine": 4,
						"startLine": 2
					}
				}
			],
			"line_range": {
				"endLine": 5,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}

test_verify_elesticsearch_default_security_group_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_elasticsearch_domain",
				"pass"
			],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "vpc_options",
					"Labels": [],
					"Attributes": {
						"security_group_ids": []
					},
					"Blocks": [],
					"line_range": {
						"endLine": 4,
						"startLine": 2
					}
				}
			],
			"line_range": {
				"endLine": 5,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}
