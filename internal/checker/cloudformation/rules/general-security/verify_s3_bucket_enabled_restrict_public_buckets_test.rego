package lib.cloudformation.CB_CFT_43

test_s3_bucket_restrict_public_buckets {
	result := passed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"PublicAccessBlockConfiguration": {"RestrictPublicBuckets": true}},
	}}}
	count(result) == 1
}

test_s3_bucket_not_restrict_public_buckets {
	result := passed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"PublicAccessBlockConfiguration": {"RestrictPublicBuckets": false}},
	}}}
	count(result) == 0
}
