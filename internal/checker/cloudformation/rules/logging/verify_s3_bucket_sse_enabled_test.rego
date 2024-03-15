package lib.cloudformation.CB_CFT_010

test_s3_bucket_sse_is_enabled {
	result := passed with input as {
        "Resources": {
            "MyS3Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {
                    "BucketEncryption": {
                        "ServerSideEncryptionConfiguration": [
                            {
                                "ServerSideEncryptionByDefault": {
                                    "SSEAlgorithm": "AES256"
                                }
                            }
                        ]
                    }
                }
            }
        }
    }
	count(result) == 1
}

test_s3_bucket_sse_is_not_enabled {
    result := failed with input as {
        "Resources": {
            "MyS3Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {
                    "BucketEncryption": {
                        "ServerSideEncryptionConfiguration": [
                            {
                                "ServerSideEncryptionByDefault": {
                                    "SSEAlgorithm": "AES257"
                                }
                            }
                        ]
                    }
                }
            }
        }
    }
    count(result) == 1
}
