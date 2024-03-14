package lib.cloudformation.CB_CFT_121

test_verify_lambda_function_delegeated_to_aws_pass {
    result := passed with input as {
        "Resources": {
            "LambdaPermission": {
                "Type": "AWS::Lambda::Permission",
                "Properties": {
                    "Action": "lambda:InvokeFunction",
                    "FunctionName": "arn:aws:lambda:us-east-1:123456789012:function:MyLambdaFunction",
                    "Principal": "s3.amazonaws.com",
                    "SourceAccount": "123456789012",
                    "SourceArn": "arn:aws:s3:::my-bucket"
                }
            }
        }
    }
    count(result) == 1
}

test_verify_lambda_function_delegeated_to_aws_fail {
    result := failed with input as {
        "Resources": {
            "LambdaPermission": {
                "Type": "AWS::Lambda::Permission",
                "Properties": {
                    "Action": "lambda:InvokeFunction",
                    "FunctionName": "arn:aws:lambda:us-east-1:123456789012:function:MyLambdaFunction",
                    "Principal": "amazonaws.com",
                    "SourceArn": "arn:aws:s3:::my-bucket"
                }
            }
        }
    }
    count(result) == 1
}
