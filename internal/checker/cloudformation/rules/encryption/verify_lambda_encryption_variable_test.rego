package lib.cloudformation.CB_CFT_108

test_lambda_function_encryption_settings_pass {
    result := passed with input as {
        "Resources": {
            "MyLambdaFunction": {
                "Type": "AWS::Serverless::Function",
                "Properties": {
                    "Environment": {
                        "Variables": {
                            "ENCRYPTION_CHECK": true
                        }
                    },
                    "KmsKeyArn": "arn:aws:kms:region:account-id:key/key-id",
                    "Timeout": 30
                }
            }
        }
    }
    count(result) == 1
}

test_lambda_function_encryption_settings_fail {
    result := failed with input as {
        "Resources": {
            "MyLambdaFunction": {
                "Type": "AWS::Serverless::Function",
                "Properties": {
                    "Environment": {},
                    "Timeout": 30
                }
            }
        }
    }
    count(result) == 1
}
