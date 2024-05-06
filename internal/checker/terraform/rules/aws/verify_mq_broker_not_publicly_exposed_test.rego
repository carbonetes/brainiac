package lib.terraform.CB_TFAWS_075
import rego.v1

test_mq_broker_not_public if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_mq_broker",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "broker_name": "example",
                                    "engine_type": "ActiveMQ",
                                    "engine_version": "5.15.0",
                                    "host_instance_type": "mq.t2.micro",
                                    "publicly_accessible": false,
                                    "security_groups": "aws_security_group.test.id"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 18,
                                    "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}

test_mq_broker_public if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_mq_broker",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "broker_name": "example",
                                    "engine_type": "ActiveMQ",
                                    "engine_version": "5.15.0",
                                    "host_instance_type": "mq.t2.micro",
                                    "publicly_accessible": true,
                                    "security_groups": "aws_security_group.test.id"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 18,
                                    "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}