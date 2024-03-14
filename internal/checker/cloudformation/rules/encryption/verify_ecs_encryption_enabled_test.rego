package lib.cloudformation.CB_CFT_072

test_ecs_volume_is_encrypted_securely_pass {
    result := passed with input as {
        "Resources": {
            "TaskDefinition": {
                "Type": "AWS::ECS::TaskDefinition",
                "Properties": {
                    "Volumes": [
                        {
                            "EFSVolumeConfiguration": {
                                "TransitEncryption": "ENABLED"
                            }
                        }
                    ]
                }
            }
        }
    }
    count(result) == 1
}

test_ecs_volume_is_not_encrypted_securely_fail {
    result := failed with input as {
        "Resources": {
            "TaskDefinition": {
                "Type": "AWS::ECS::TaskDefinition",
                "Properties": {
                    "Volumes": [
                        {
                            "EFSVolumeConfiguration": {
                                "TransitEncryption": "DISABLED"
                            }
                        }
                    ]
                }
            }
        }
    }
    count(result) == 1
}
