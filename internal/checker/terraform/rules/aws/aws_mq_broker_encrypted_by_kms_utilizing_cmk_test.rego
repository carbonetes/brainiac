package lib.terraform.CB_TFAWS_233
import rego.v1

test_aws_mq_broker_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_mq_broker",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "broker_name": "example",
                                    "engine_type": "ActiveMQ",
                                    "engine_version": "5.15.13",
                                    "host_instance_type": "mq.t2.micro",
                                    "security_groups": "aws_security_group.test.id"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "id": "aws_mq_configuration.fail.id",
                                        "revision": "aws_mq_configuration.fail.latest_revision"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 4
                                        }
                                    },
                                    {
                                        "Type": "user",
                                        "Labels": [],
                                        "Attributes": {
                                        "password": "MindTheGapps",
                                        "username": "ExampleUser"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 17,
                                        "startLine": 14
                                        }
                                    },
                                    {
                                        "Type": "encryption_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "kms_key_id": "aws_kms_key.example.arn",
                                        "use_aws_owned_key": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 22,
                                        "startLine": 19
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 23,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_mq_broker_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_mq_broker",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "broker_name": "example",
                                    "engine_type": "ActiveMQ",
                                    "engine_version": "5.15.13",
                                    "host_instance_type": "mq.t2.micro",
                                    "security_groups": "aws_security_group.test.id"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "id": "aws_mq_configuration.fail.id",
                                        "revision": "aws_mq_configuration.fail.latest_revision"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 4
                                        }
                                    },
                                    {
                                        "Type": "user",
                                        "Labels": [],
                                        "Attributes": {
                                        "password": "MindTheGapps",
                                        "username": "ExampleUser"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 17,
                                        "startLine": 14
                                        }
                                    },
                                    {
                                        "Type": "encryption_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "kms_key_id": "",
                                        "use_aws_owned_key": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 22,
                                        "startLine": 19
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 23,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
