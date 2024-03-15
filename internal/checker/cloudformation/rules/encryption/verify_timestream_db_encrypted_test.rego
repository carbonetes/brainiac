package lib.cloudformation.CB_CFT_099

test_timestream_db_encrypted_pass {
	result := passed with input as {
		"Resources": {
			"MyTimestreamDatabase": {
				"Type": "AWS::Timestream::Database",
				"Properties": {
					"KmsKeyId": "arn:aws:kms:us-east-1:123456789012:key/abcd1234-abcd-1234-abcd-1234567890ab"
				}
			}
		}
	}
	count(result) == 1
}

test_timestream_db_encrypted_fail {
	result := failed with input as {
		"Resources": {
			"MyTimestreamDatabase": {
				"Type": "AWS::Timestream::Database",
				"Properties": {
					"KmsKeyId": ""
				}
			}
		}
	}
	count(result) == 1
}
