package lib.cloudformation.CB_CFT_084

test_aws_lambda_function_concurrent_execution_configured {
	result := passed with input as {"Resources": {
    "MyLambdaFunction": {
      "Type": "AWS::Lambda::Function",
      "Properties": {
        "FunctionName": "YourLambdaFunctionName",
        "Handler": "index.handler",
        "Role": "arn:aws:iam::123456789012:role/YourLambdaRole",
        "Runtime": "nodejs14.x",
        "Timeout": 30,
        "ReservedConcurrentExecutions": 5
      }
    }
  }
}
	count(result) == 1
}

test_aws_lambda_function_concurrent_execution_not_configured {
	result := failed with input as {"Resources": {
    "MyLambdaFunction": {
      "Type": "AWS::Lambda::Function",
      "Properties": {
        "FunctionName": "YourLambdaFunctionName",
        "Handler": "index.handler",
        "Role": "arn:aws:iam::123456789012:role/YourLambdaRole",
        "Runtime": "nodejs14.x",
        "Timeout": 30,
      }
    }
  }
}
	 count(result) == 1
}
