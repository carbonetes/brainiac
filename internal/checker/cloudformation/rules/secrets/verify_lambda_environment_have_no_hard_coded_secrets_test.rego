package lib.cloudformation.CB_CFT_031

test_no_hard_coded_lambda_environment {
    passed := {
        "Resources": {
            "MyLambdaFunction": {
                "Properties": {
                    "Environment": {
                        "Variables": {
                            "key1": "arn:aws:secretsmanager::secret:",
                            "key2": "",
                        }
                    }
                },
                "Type": "AWS::Lambda::Function"
            }
        }
    }
    count(passed) == 1
}

test_has_hard_coded_lambda_environment {
    failed := {
        "Resources": {
            "MyLambdaFunction": {
                "Properties": {
                    "Environment": {
                        "Variables": {
                            "key1": "arn:aws:secretsmanager:us-east-1:123456789012:secret:my-secret",
                            "key2": "",
                        }
                    }
                },
                "Type": "AWS::Lambda::Function"
            }
        }
    }
    count(failed) == 1
}
