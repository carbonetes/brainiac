package lib.cloudformation.CB_CFT_025

test_cloudtrail_encryption_pass {
    result := passed with input as {
        "Resources": {
            "MyCloudTrail": {
                "Type": "AWS::CloudTrail::Trail",
                "Properties": {
                    "KMSKeyId": "arn:aws:kms:us-east-1:123456789012:key/abcd1234-12ab-34cd-56ef-1234567890ab",

                },
            }
        }
    }
    count(result) == 1
}

test_cloudtrail_encryption_fail {
    result := failed with input as {
        "Resources": {
            "MyCloudTrail": {
                "Type": "AWS::CloudTrail::Trail",
                "Properties": {
                    "KMSKeyId": "",
                },
            }
        }
    }
    count(result) == 1
}
