package lib.cloudformation.CB_CFT_049

test_cloudtrail_encryption_pass {
    result := passed with input as {
        "Resources": {
            "MyCloudTrail": {
                "Type": "AWS::CloudTrail::Trail",
                "Properties": {
                    "IsMultiRegionTrail": true,
                }
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
                    "IsMultiRegionTrail": false,
                }
            }
        }
    }
    count(result) == 1
}
