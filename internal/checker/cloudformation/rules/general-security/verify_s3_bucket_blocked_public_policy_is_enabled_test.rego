package lib.cloudformation.CB_CFT_036

test_s3_bucket_public_policy_blocked {
	result := passed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"PublicAccessBlockConfiguration": {"BlockPublicPolicy": true}},
	}}}
	count(result) == 1
}

test_s3_bucket_public_policy_not_blocked {
	result := failed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"PublicAccessBlockConfiguration": {"BlockPublicPolicy": false}},
	}}}
	count(result) == 1
}
