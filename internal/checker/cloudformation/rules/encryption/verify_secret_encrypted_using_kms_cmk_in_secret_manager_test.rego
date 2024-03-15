package lib.cloudformation.CB_CFT_093

test_secret_manager_encrypted_kms_cmk {
	result := passed with input as {"Resources": {"MySecret": {
        "Type": "AWS::SecretsManager::Secret",
        "Properties": {
              "KmsKeyId": "arn:aws:kms:region:account-id:key/key-id"
        }
    }}}
	count(result) == 1
}

test_secret_manager_not_encrypted_kms_cmk {
	result := failed with input as {"Resources": {"MySecret": {
        "Type": "AWS::SecretsManager::Secret",
        "Properties": {
              "KmsKeyId": ""
        }
    }}}
	count(result) == 1
}
