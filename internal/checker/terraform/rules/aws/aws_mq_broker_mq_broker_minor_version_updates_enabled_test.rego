package lib.terraform.CB_TFAWS_206
import rego.v1

test_aws_mq_broker_mq_broker_minor_version_updates_enabled_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_mq_broker",
                                "example"
                                ],
                                "Attributes": {
                                "auto_minor_version_upgrade": true,
                                "broker_name": "example",
                                "engine_type": "ActiveMQ",
                                "engine_version": "5.15.9",
                                "host_instance_type": "mq.t3.micro"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 7,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}

test_aws_mq_broker_mq_broker_minor_version_updates_enabled_failed if {
result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_mq_broker",
                                "example"
                                ],
                                "Attributes": {
                                "auto_minor_version_upgrade": false,
                                "broker_name": "example",
                                "engine_type": "ActiveMQ",
                                "engine_version": "5.15.9",
                                "host_instance_type": "mq.t3.micro"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 7,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}