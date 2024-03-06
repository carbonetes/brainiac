package lib.cloudformation.CB_CFT_45

test_eks_cluster_is_encrypted {
	result := passed with input as {"Resources": {"MyEKSCluster": {
		"Type": "AWS::DAX::Cluster",
		"Properties": {"EncryptionConfig": [{"Resources": ["secrets"]}]},
	}}}
	count(result) == 0
}

test_eks_cluster_is_not_encrypted {
	result := failed with input as {"Resources": {"MyEKSCluster": {
		"Type": "AWS::DAX::Cluster",
		"Properties": {"EncryptionConfig": [{"Resources": [""]}]},
	}}}
	count(result) == 0
}
