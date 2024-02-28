package lib.cloudformation.CB_CFT_007

test_rds_at_rest_is_encrypted {
	result := passed with input as {"Resources": {"NewRDS": {
		"Type": "AWS::RDS::DBInstance",
		"Properties": {
			"StorageEncrypted": true,
            "Engine": "aurora"
		},
	}}}
	count(result) == 1
}

test_rds_at_rest_is_not_encrypted {
	result := failed with input as {"Resources": {"NewRDS": {
		"Type": "AWS::RDS::DBInstance",
		"Properties": {
			"StorageEncrypted": false,
            "Engine": "aurora"
		},
	}}}
	count(result) == 1
}
