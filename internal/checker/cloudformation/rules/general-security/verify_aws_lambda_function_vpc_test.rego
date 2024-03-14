package lib.cloudformation.CB_CFT_086

test_aws_lambda_function_vpc_configured {
	result := passed with input as {"Resources": {
    "MyLambdaFunction": {
      "Type": "AWS::Lambda::Function",
      "Properties": {
        "Handler": "index.handler",
        "Role": "arn:aws:iam::account-id:role/execution_role",
        "FunctionName": "MyLambdaFunction",
        "Runtime": "nodejs14.x",
        "Code": {
          "S3Bucket": "your-s3-bucket",
          "S3Key": "your-s3-key"
        },
        "VpcConfig": {
          "SecurityGroupIds": ["sg-xxxxxxxxxxxxxxxxx"],
          "SubnetIds": ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]
        }
      }
    }
  }
}
	count(result) == 1
}

test_aws_lambda_function_vpc_not_configured {
	result := failed with input as {"Resources": {
    "MyLambdaFunction": {
      "Type": "AWS::Lambda::Function",
      "Properties": {
        "Handler": "index.handler",
        "Role": "arn:aws:iam::account-id:role/execution_role",
        "FunctionName": "MyLambdaFunction",
        "Runtime": "nodejs14.x",
        "Code": {
          "S3Bucket": "your-s3-bucket",
          "S3Key": "your-s3-key"
        }
      }
    }
  }
}
	count(result) == 1
}
