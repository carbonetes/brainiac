package lib.cloudformation.CB_CFT_022

test_ecr_policy_not_public {
	result := passed with input as {
		"Resources": {
			"ECRRepository": {
				"Type": "AWS::ECR::Repository",
				"Properties": {
					"RepositoryPolicyText": {
						"Statement": [{
							"Principal": {
								"AWS": "arn:aws:iam::123456789012:user/Bob"
							},
							"Condition": {
								"Bool": {
									"aws:SecureTransport": "true"
	}}}]}}}}}
	count(result) == 1
}

test_ecr_policy_is_public {
	result := failed with input as {
		"Resources": {
			"ECRRepository": {
				"Type": "AWS::ECR::Repository",
				"Properties": {
					"RepositoryPolicyText": {
						"Statement": [{
							"Principal": {
								"AWS": "*"
							},
							"Condition": {
								"Bool": {
									"aws:SecureTransport": "false"
	}}}]}}}}}
	count(result) == 1
}
