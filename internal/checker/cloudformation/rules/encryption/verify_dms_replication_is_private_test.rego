package lib.cloudformation.CB_CFT_070

test_dms_replication_is_private {
	result := passed with input as {"Resources": {"MyReplicationInstance": {
		"Type": "AWS::DMS::ReplicationInstance",
		"Properties": {"PubliclyAccessible": false},
	}}}
	count(result) == 1
}

test_s3_bucket_public_policy_not_blocked {
	result := passed with input as {"Resources": {"MyReplicationInstance": {
		"Type": "AWS::DMS::ReplicationInstance",
		"Properties": {"PubliclyAccessible": true},
	}}}
	count(result) == 0
}
