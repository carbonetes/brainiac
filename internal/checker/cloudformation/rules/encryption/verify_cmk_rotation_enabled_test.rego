package lib.cloudformation.CB_CFT_005

test_cmk_rotation_is_enabled {
	result := passed with input as {"Resources": {"newKey": {
		"Type": "AWS::KMS::Key",
		"Properties": {
			 "EnableKeyRotation": true,
		},
	}}}
	count(result) == 1
}

test_cmk_rotation_is_not_enabled {
	result := failed with input as {"Resources": {"newKey": {
		"Type": "AWS::KMS::Key",
		"Properties": {
			 "EnableKeyRotation": false,
		},
	}}}
	count(result) == 1
}
