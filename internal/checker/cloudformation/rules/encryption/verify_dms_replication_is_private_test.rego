package lib.cloudformation.CB_CFT_065

test_dms_replication_is_private {
	result := passed with input as {"Resources": {"MyReplicationInstance": {
		"Type": "AWS::DMS::ReplicationInstance",
		"Properties": {"PubliclyAccessible": false},
	}}}
	count(result) == 1
}

test_dms_replication_is_not_private {
	result := passed with input as {"Resources": {"MyReplicationInstance": {
		"Type": "AWS::DMS::ReplicationInstance",
		"Properties": {"PubliclyAccessible": true},
	}}}
	count(result) == 0
}
