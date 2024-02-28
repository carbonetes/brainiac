package lib.cloudformation.CB_CFT_006

test_launch_config_ebs_is_encrypted {
	result := passed with input as {
    "Resources": {
        "newLaunchConfig": {
            "Type": "AWS::AutoScaling::LaunchConfiguration",
            "Properties": {
                "BlockDeviceMappings": [
                    {
                    "Ebs": {
                    "Encrypted": true
                    }
                    },
                    {
                    "Ebs": {
                    "Encrypted": true,
                    }
                    }
                ]
            }
        }
    }
}
	count(result) == 1
}

test_launch_config_ebs_is_not_encrypted {
	result := failed with input as {
    "Resources": {
        "newLaunchConfig": {
            "Type": "AWS::AutoScaling::LaunchConfiguration",
            "Properties": {
               "BlockDeviceMappings": [
                    {
                    "Ebs": {
                    "Encrypted": false
                    }
                    },
                    {
                    "Ebs": {
                    "Encrypted": true,
                    }
                    }
                ]
            }
        }
    }
}
	count(result) == 1
}
