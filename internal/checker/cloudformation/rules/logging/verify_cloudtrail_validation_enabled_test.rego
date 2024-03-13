package lib.cloudformation.CB_CFT_026

test_cloudtrail_validation_enabled_pass {
    result := passed with input as {
        "Resources": {
            "MyCloudTrail": {
                "Type": "AWS::CloudTrail::Trail",
                "Properties": {
                    "EnableLogFileValidation": true,

                },
            }
        }
    }
    count(result) == 1
}

test_cloudtrail_validation_not_enabled_fail {
    result := failed with input as {
        "Resources": {
            "MyCloudTrail": {
                "Type": "AWS::CloudTrail::Trail",
                "Properties": {
                    "EnableLogFileValidation": false,
                },
            }
        }
    }
    count(result) == 1
}
