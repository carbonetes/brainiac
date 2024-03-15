package lib.cloudformation.CB_CFT_012

test_s3_bucket_versioning_enabled {
    result := passed with input as {"Resources": {
        "S3Bucket": {
            "Type": "AWS::S3::Bucket",
            "Properties": {
                "VersioningConfiguration": {
                    "Status": "Enabled"
                }
            },
        }}}
        count(result) == 1
}

test_s3_bucket_versioning_not_enabled {
    result := failed with input as {"Resources": {
        "S3Bucket": {
            "Type": "AWS::S3::Bucket",
            "Properties": {
                "VersioningConfiguration": {
                    "Status": "Disabled"
                }
            },
        }}}
        count(result) == 1
}