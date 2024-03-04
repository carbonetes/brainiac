package lib.cloudformation.CB_CFT_011

test_s3_bucket_read_permissions_is_restricted {
	result := passed with input as {
    "Resources": {
        "S3Bucket": {
            "Type": "AWS::S3::Bucket",
            "Properties": {
                "AccessControl": "Private"
            }
        }
    }
}
	count(result) == 1
}

test_s3_bucket_read_permissions_is_not_restricted {
    result := failed with input as {
        "Resources": {
            "S3Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {
                    "AccessControl": "PublicRead"
                }
            }
        }
    }
    count(result) == 1
}
