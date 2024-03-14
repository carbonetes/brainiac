package lib.cloudformation.CB_CFT_098

test_kms_encrypted_in_cloudwatch_log_group{
    result := passed with input as {
        "Resources": {
            "MyLogGroup": {
                "Type": "AWS::Logs::LogGroup",
                "Properties": {
                    "KmsKeyId": "arn:aws:kms:us-east-1:123456789012:key/abcd1234-a123-456a-a12b-a123b4c5d678"
                }
            }
        }
    }
    count(result) == 1
}

test_kms_not_encrypted_in_cloudwatch_log_group{
    result := failed with input as {
        "Resources": {
            "MyLogGroup": {
                "Type": "AWS::Logs::LogGroup",
                "Properties": {
                    "KmsKeyId": ""
                }
            }
        }
    }
    count(result) == 1
}
