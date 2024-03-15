package lib.cloudformation.CB_CFT_016

test_verify_sns_topic_encryption {
    result := passed with input as {"Resources": {
        "MySNSTopic": {
            "Type": "AWS::SNS::Topic",
            "Properties": {
                "DisplayName": "MySNSTopic",
                "Subscription": [
                    {
                        "Protocol": "email",
                        "Endpoint": "example@example.com"
                    }
                ],
                "KmsMasterKeyId": "alias/aws/sns",
                "TopicName": "MySNSTopic"
            }
        }
    }
}
        count(result) == 1
}

test_verify_sns_topic_without_encryption {
    result := failed with input as {"Resources": {
        "MySNSTopic": {
            "Type": "AWS::SNS::Topic",
            "Properties": {
                "DisplayName": "MySNSTopic",
                "Subscription": [
                    {
                        "Protocol": "email",
                        "Endpoint": "example@example.com"
                    }
                ],
                "TopicName": "MySNSTopic"
            }
        }
    }
}
        count(result) == 1
}