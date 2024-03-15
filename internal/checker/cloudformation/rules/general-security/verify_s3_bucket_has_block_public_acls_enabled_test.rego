package lib.cloudformation.CB_CFT_035

test_s3_bucket_public_acls_blocked {
	result := passed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"PublicAccessBlockConfiguration": {"BlockPublicAcls": true}},
	}}}
	count(result) == 1
}

test_s3_bucket_public_acls_not_blocked {
	result := failed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"PublicAccessBlockConfiguration": {"BlockPublicAcls": false}},
	}}}
	count(result) == 1
}
