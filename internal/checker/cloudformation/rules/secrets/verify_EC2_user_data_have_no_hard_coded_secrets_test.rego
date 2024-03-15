package lib.cloudformation.CB_CFT_032

test_no_hard_coded_secrets_user_data {
    passed := {
        "Resources": {
            "MyLambdaFunction": {
                "Properties": {
                    "UserData": {
                        "Fn::Base64": "arn:aws::secret:"
                    }
                },
                "Type": "AWS::Lambda::Function"
            }
        }
    }
    count(passed) == 1
}

test_has_hard_coded_user_data {
    failed := {
        "Resources": {
            "MyLambdaFunction": {
                "Properties": {
                    "UserData": {
                        "Fn::Base64": "arn:aws:secretsmanager:us-east-1:123456789012:secret:my-secret"
                    }
                },
                "Type": "AWS::Lambda::Function"
            }
        }
    }
    count(failed) == 1
}
