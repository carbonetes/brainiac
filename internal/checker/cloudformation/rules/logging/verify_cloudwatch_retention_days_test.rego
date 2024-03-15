package lib.cloudformation.CB_CFT_048

test_cloudwatch_loggroup_retention_specified_pass {
    result := passed with input as {
        "Resources": {
            "MyLogGroup": {
                "Type": "AWS::Logs::LogGroup",
                "Properties": {
                    "RetentionInDays": 30
                }
            }
        }
    }
    count(result) == 1
}

test_cloudwatch_loggroup_retention_not_specified_fail {
    result := failed with input as {
        "Resources": {
            "MyLogGroup": {
                "Type": "AWS::Logs::LogGroup",
                "Properties": {
                    "RetentionInDays": 0
                }
            }
        }
    }
    count(result) == 1
}
