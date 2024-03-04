package lib.cloudformation.CB_CFT_44

test_s3_bucket_write_access_private {
	result := passed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"AccessControl": "Private"},
	}}}
	count(result) == 1
}

test_s3_bucket_write_access_public {
	result := passed with input as {"Resources": {"MyS3Bucket": {
		"Type": "AWS::S3::Bucket",
		"Properties": {"AccessControl": "Public"},
	}}}
	count(result) == 0
}
