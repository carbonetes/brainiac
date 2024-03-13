package lib.cloudformation.CB_CFT_064

test_no_public_ip_ec2_instance {
    result := passed with input as {
        "Resources": {
            "MyEC2Instance": {
                "Type": "AWS::EC2::Instance",
                "Properties": {
                    "NetworkInterfaces": [
                        {
                            "AssociatePublicIpAddress": false
                        }
                    ]
                }
            }
        }
    }
    count(result) == 1
}

test_public_ip_ec2_instance_exist {
    result := failed with input as {
        "Resources": {
            "MyEC2Instance": {
                "Type": "AWS::EC2::Instance",
                "Properties": {
                    "NetworkInterfaces": [
                        {
                            "AssociatePublicIpAddress": true
                        }
                    ]
                }
            }
        }
    }
    count(result) == 1
}

test_no_public_ip_ec2_instance_launchtemplate {
    result := passed with input as {
        "Resources": {
            "MyLaunchTemplate": {
                "Type": "AWS::EC2::LaunchTemplate",
                "Properties": {
                    "LaunchTemplateData": {
                        "NetworkInterfaces": [
                            {
                                "AssociatePublicIpAddress": false
                            }
                        ]
                    }
                }
            }
        }
    }
    count(result) == 1
}

test_public_ip_ec2_instance_launchtemplate_exist {
    result := failed with input as {
        "Resources": {
            "MyLaunchTemplate": {
                "Type": "AWS::EC2::LaunchTemplate",
                "Properties": {
                    "LaunchTemplateData": {
                        "NetworkInterfaces": [
                            {
                                "AssociatePublicIpAddress": true
                            }
                        ]
                    }
                }
            }
        }
    }
    count(result) == 1
}
