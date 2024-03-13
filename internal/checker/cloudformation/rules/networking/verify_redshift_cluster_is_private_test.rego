package lib.cloudformation.CB_CFT_063

test_redshift_cluster_is_private {
	result := passed with input as {"Resources": {"MyRedshiftCluster": {
		"Properties": {"PubliclyAccessible": false},
		"Type": "AWS::Redshift::Cluster",
	}}}
	count(result) == 1
}

test_has_hard_coded_lambda_environment {
	result := failed with input as {"Resources": {"MyRedshiftCluster": {
		"Properties": {"PubliclyAccessible": true},
		"Type": "AWS::Redshift::Cluster",
	}}}
	count(result) == 1
}
