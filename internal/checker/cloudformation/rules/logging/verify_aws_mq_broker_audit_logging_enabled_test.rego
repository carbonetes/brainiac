package lib.cloudformation.CB_CFT_114

test_verify_aws_mq_broker_audit_logs_enabled {
    result := passed with input as {"Resources": {
        "MyMQBroker": {
            "Type": "AWS::AmazonMQ::Broker",
            "Properties": {
                "Configuration": {
                    "Audit": {
                        "Logs": true
                    }
                }
            }
        }
    }
}
        count(result) == 1
}

test_verify_aws_mq_broker_audit_logs_disabled {
    result := failed with input as {"Resources": {
        "MyMQBroker": {
            "Type": "AWS::AmazonMQ::Broker",
            "Properties": {
                "Configuration": {
                    "Audit": {
                        "Logs": false
                    }
                }
            }
        }
    }
}
        count(result) == 1
}