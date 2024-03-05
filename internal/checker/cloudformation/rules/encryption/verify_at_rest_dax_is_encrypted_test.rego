package lib.cloudformation.CB_CFT_38

test_s3_dax_at_rest_encrypted {
	result := passed with input as {"Resources": {"MyDAXCluster": {
		"Type": "AWS::DAX::Cluster",
		"Properties": {
			"AtRestEncryptionEnabled": true,
			"SSESpecification": {"SSEEnabled": true},
		},
	}}}
	count(result) == 1
}

test_s3_dax_at_rest_not_encrypted {
	result := failed with input as {"Resources": {"MyDAXCluster": {
		"Type": "AWS::DAX::Cluster",
		"Properties": {
			"AtRestEncryptionEnabled": false,
			"SSESpecification": {"SSEEnabled": false},
		},
	}}}
	count(result) == 1
}
