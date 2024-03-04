    package lib.cloudformation.CB_CFT_009

test_s3_bucket_logging_is_enabled {
    result := passed with input as {
        "Resources": {
            "NewS3Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {
                    "LoggingConfiguration": {
                        "DestinationBucketName": "LoggingBucket"
                    }
                }
            }
        }
    }
        count(result) == 1
    }

test_s3_bucket_logging_is_not_enabled {
    result := failed with input as {
        "Resources": {
            "NewS3Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {}
            }
        }
    }
    count(result) == 1
}
