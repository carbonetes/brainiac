package lib.cloudformation.CB_CFT_040

test_eks_cluster_is_encrypted {
	result := passed with input as {"Resources": { "EnableSecretsEncryption": {
			"Properties": {
				"EncryptionConfig": [{
					"Resources": [
						"secrets"
					],
				}]
			},
			"Type": "AWS::EKS::Cluster",
		}
	}}
	count(result) == 1
}

test_eks_cluster_is_not_encrypted {
	result := failed with input as {"Resources": { "EnableSecretsEncryption": {
			"Properties": {
				"EncryptionConfig": [{
					"Resources": [
						""
					],
				}]
			},
			"Type": "AWS::EKS::Cluster",
		}
	}}
	count(result) == 1
}
