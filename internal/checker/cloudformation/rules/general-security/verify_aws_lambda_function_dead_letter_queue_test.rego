package lib.cloudformation.CB_CFT_085

test_aws_lambda_function_concurrent_execution_configured {
	result := passed with input as {"Resources": {
    "LambdaFunctionWithDLQ": {
      "Type": "AWS::Lambda::Function",
      "Properties": {
        "Handler": "index.handler",
        "Role": "arn:aws:iam::your-account-id:role/your-execution-role",
        "FunctionName": "MyLambdaFunction",
        "Runtime": "nodejs14.x",
        "DeadLetterConfig": {
          "TargetArn": "arn:aws:sqs:your-region:your-account-id:your-dlq-queue"
        }
      }
    }
  }
}
	count(result) == 1
}

test_aws_lambda_function_concurrent_execution_not_configured {
	result := failed with input as {"Resources": {
    "LambdaFunctionWithDLQ": {
      "Type": "AWS::Lambda::Function",
      "Properties": {
        "Handler": "index.handler",
        "Role": "arn:aws:iam::your-account-id:role/your-execution-role",
        "FunctionName": "MyLambdaFunction",
        "Runtime": "nodejs14.x",
        "DeadLetterConfig": {
        }
      }
    }
  }
}
	count(result) == 1
}
