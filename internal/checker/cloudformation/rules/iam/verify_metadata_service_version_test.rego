package lib.cloudformation.CB_CFT_057

test_verify_imdsv1_disabled {
    result := passed with input as {"Resources": {
        "MyLaunchTemplate": {
            "Type": "AWS::EC2::LaunchTemplate",
            "Properties": {
                "LaunchTemplateData": {
                    "MetadataOptions": {
                        "HttpEndpoint": "disabled",
                        "HttpTokens": "required"
                    }
                }
            }
        }
    }}
    count(result) == 1
}

test_verify_imdsv1_enabled {
    result := failed with input as {"Resources": {
        "MyLaunchTemplate": {
            "Type": "AWS::EC2::LaunchTemplate",
            "Properties": {
                "LaunchTemplateData": {
                    "MetadataOptions": {
                        "HttpEndpoint": "enabled",
                        "HttpTokens": "optional"
                    }
                }
            }
        }
    }}
    count(result) == 1
}