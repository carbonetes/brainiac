package lib.terraform.CB_TFAWS_188
import rego.v1

test_aws_mq_broker_mq_broker_audit_logging_enabled_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_mq_broker",
                                "enabled"
                                ],
                                "Attributes": {
                                "broker_name": "example",
                                "engine_type": "ActiveMQ",
                                "engine_version": "5.16.3",
                                "host_instance_type": "mq.t3.micro"
                                },
                                "Blocks": [
                                {
                                    "Type": "user",
                                    "Labels": [],
                                    "Attributes": {
                                    "password": "admin123",
                                    "username": "admin"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 10,
                                    "startLine": 7
                                    }
                                },
                                {
                                    "Type": "logs",
                                    "Labels": [],
                                    "Attributes": {
                                    "audit": true,
                                    "general": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 15,
                                    "startLine": 12
                                    }
                                }
                                ],
                                "line_range": {
                                "endLine": 16,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}

test_aws_mq_broker_mq_broker_audit_logging_enabled_failed if {
result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_mq_broker",
                                "enabled"
                                ],
                                "Attributes": {
                                "broker_name": "example",
                                "engine_type": "ActiveMQ",
                                "engine_version": "5.16.3",
                                "host_instance_type": "mq.t3.micro"
                                },
                                "Blocks": [
                                {
                                    "Type": "user",
                                    "Labels": [],
                                    "Attributes": {
                                    "password": "admin123",
                                    "username": "admin"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 10,
                                    "startLine": 7
                                    }
                                },
                                {
                                    "Type": "logs",
                                    "Labels": [],
                                    "Attributes": {
                                    "audit": false,
                                    "general": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 15,
                                    "startLine": 12
                                    }
                                }
                                ],
                                "line_range": {
                                "endLine": 16,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}