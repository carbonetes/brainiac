package lib.cloudformation.CB_CFT_017

test_verify_sqs_queue_encryption {
    result := passed with input as {"Resources": {
        "MySQSQueue": {
            "Type": "AWS::SQS::Queue",
            "Properties": {
                "DisplayName": "MySQSQueue",
                "Subscription": [
                    {
                        "Protocol": "email",
                        "Endpoint": "example@example.com"
                    }
                ],
                "KmsMasterKeyId": "alias/aws/sns",
                "TopicName": "MySQSQueue"
            }
        }
    }
}
        count(result) == 1
}

test_verify_sqs_queue_without_encryption {
    result := failed with input as {"Resources": {
        "MySQSQueue": {
            "Type": "AWS::SQS::Queue",
            "Properties": {
                "DisplayName": "MySQSQueue",
                "Subscription": [
                    {
                        "Protocol": "email",
                        "Endpoint": "example@example.com"
                    }
                ],
                "TopicName": "MySQSQueue"
            }
        }
    }
}
        count(result) == 1
}