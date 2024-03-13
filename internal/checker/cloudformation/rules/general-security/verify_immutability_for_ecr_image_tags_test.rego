package lib.cloudformation.CB_CFT_034

test_ecr_image_tags_immutable {
	result := passed with input as {"Resources": {"MyRepository": {
		"Type": "AWS::ECR::Repository",
		"Properties": {"ImageTagMutability": "IMMUTABLE"},
	}}}
	count(result) == 1
}

test_ecr_image_tags_not_immutable {
	result := passed with input as {"Resources": {"MyRepository": {
		"Type": "AWS::ECR::Repository",
		"Properties": {"ImageTagMutability": "NOT IMMUTABLE"},
	}}}
	count(result) == 0
}
