package lib.cloudformation.CB_CFT_071

test_s3_bucket_public_policy_blocked {
	result := passed with input as {"Resources": {"DocDBParameterGroupEnabled": {
		"Type": "AWS::DocDB::DBClusterParameterGroup",
		"Properties": {"Parameters": {"tls": "enabled"}},
	}}}
	count(result) == 1
}

test_s3_bucket_public_policy_not_blocked {
	result := passed with input as {"Resources": {"DocDBParameterGroupEnabled": {
		"Type": "AWS::DocDB::DBClusterParameterGroup",
		"Properties": {"Parameters": {"tls": "disabled"}},
	}}}
	count(result) == 0
}
