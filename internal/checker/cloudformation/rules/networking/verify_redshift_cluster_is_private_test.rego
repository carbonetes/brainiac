package lib.cloudformation.CB_CFT_068

test_redshift_cluster_is_private {
	passed := {"Resources": {"MyRedshiftCluster": {
		"Properties": {"PubliclyAccessible": false},
		"Type": "AWS::Redshift::Cluster",
	}}}
	count(passed) == 1
}

test_has_hard_coded_lambda_environment {
	failed := {"Resources": {"MyRedshiftCluster": {
		"Properties": {"PubliclyAccessible": true},
		"Type": "AWS::Redshift::Cluster",
	}}}
	count(failed) == 1
}
