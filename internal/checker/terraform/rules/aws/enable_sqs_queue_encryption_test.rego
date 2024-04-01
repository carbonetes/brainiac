package lib.terraform.CB_TFAWS_014
import rego.v1

test_enable_sqs_queue_encryption_passed if {
    result := passed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_sqs_queue",
                                        "example_sqs_queue"
                                    ],
                                    "Attributes": {
                                        "content_based_deduplication": false,
                                        "delay_seconds": "0",
                                        "fifo_queue": false,
                                        "kms_data_key_reuse_period_seconds": "300",
                                        "kms_master_key_id": "alias/aws/sqs",
                                        "maximum_message_size": "262144",
                                        "message_retention_seconds": "345600",
                                        "name": "example-queue",
                                        "receive_wait_time_seconds": "0"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 17,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}

test_enable_sqs_queue_encryption_failed if {
result := failed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_sqs_queue",
                                        "example_sqs_queue"
                                    ],
                                    "Attributes": {
                                        "content_based_deduplication": false,
                                        "delay_seconds": "0",
                                        "fifo_queue": false,
                                        "kms_data_key_reuse_period_seconds": "300",
                                        "maximum_message_size": "262144",
                                        "message_retention_seconds": "345600",
                                        "name": "example-queue",
                                        "receive_wait_time_seconds": "0"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 17,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}