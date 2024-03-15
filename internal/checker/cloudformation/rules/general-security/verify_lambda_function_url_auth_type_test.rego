package lib.cloudformation.CB_CFT_115

test_verify_lambda_function_url_auth_type_configured {
    result := passed with input as {"Resources": {
        "MyLambdaFunction": {
            "Type": "AWS::Lambda::Url",
            "Properties": {
                "AuthType": "AWS_IAM"
            }
        }
    }
}
        count(result) == 1
}

test_verify_lambda_function_url_auth_type_not_configured {
    result := failed with input as {"Resources": {
        "MyLambdaFunction": {
            "Type": "AWS::Lambda::Url",
            "Properties": {
                "AuthType": "NONE"
            }
        }
    }
}
        count(result) == 1
}