package lib.cloudformation.CB_CFT_092

test_kms_encryption_ecr_repositories {
	result := passed with input as {"Resources": { "MyECRRepository": {
			"Properties": {
				"EncryptionConfiguration": {
					"EncryptionType": "KMS"
				}
			},
			"Type": "AWS::ECR::Repository",
		}
	}}
	count(result) == 1
}

test_not_kms_encryption_ecr_repositories {
	result := failed with input as {"Resources": { "MyECRRepository": {
			"Properties": {
				"EncryptionConfiguration": {
					"EncryptionType": "AES256"
				}
			},
			"Type": "AWS::ECR::Repository",
		}
	}}
	count(result) == 1
}
