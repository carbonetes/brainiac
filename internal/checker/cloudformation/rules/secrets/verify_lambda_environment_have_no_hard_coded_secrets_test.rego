package lib.cloudformation.CB_CFT_35

test_no_hard_coded_lambda_environment {
	result := passed with input as {
		"Resources": {
			"MyLambdaFunction": {
				"Type": "AWS::Lambda::Function",
				"Properties": {
					"Environment": {
						"Variables": {
							"key1": "not_a_secret",
							"key2": "not_a_secret",
						},
					},
				},
			},
		},
	}
	count(result) == 1
}

test_hard_coded_lambda_environment {
	result := failed with input as {
		"Resources": {
			"MyLambdaFunction": {
				"Type": "AWS::Lambda::Function",
				"Properties": {
					"Environment": {
						"Variables": {
							"key1": "not_a_secret",
							"key2": "secret",
						},
					},
				},
			},
		},
	}
	count(result) == 0
}