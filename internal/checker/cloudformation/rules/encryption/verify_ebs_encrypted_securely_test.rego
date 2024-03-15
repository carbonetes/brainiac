package lib.cloudformation.CB_CFT_002

test_ebs_is_encrypted_securely {
	result := passed with input as {
    "Resources": {
        "NewVolume": {
            "Type": "AWS::EC2::Volume",
            "Properties": {
                "Encrypted": true,
            }
        }
    }
}
	count(result) == 1
}

test_ebs_is_not_encrypted_securely {
	result := failed with input as {
    "Resources": {
        "NewVolume": {
            "Type": "AWS::EC2::Volume",
            "Properties": {
                "Encrypted": false,
            }
        }
    }
}
	count(result) == 1
}
