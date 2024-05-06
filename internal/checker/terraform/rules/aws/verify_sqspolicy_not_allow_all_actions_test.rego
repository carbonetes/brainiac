package lib.terraform.CB_TFAWS_079
import rego.v1

test_sqspolicy_not_allow_all_actions if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_sqs_queue_policy",
                                    "example_policy"
                                    ],
                                    "Attributes": {
                                    "policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"DisallowAllActions\",\n      \"Effect\": \"Allow\",\n      \"Principal\": \"*\",\n      \"Action\": \"sqs:SendMessage\"\n    }\n  ]\n}\n",
                                    "queue_url": "aws_sqs_queue.example_queue.id"
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

test_sqspolicy_allow_all_actions if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_sqs_queue_policy",
                                    "example_policy"
                                    ],
                                    "Attributes": {
                                    "policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"DisallowAllActions\",\n      \"Effect\": \"Allow\",\n      \"Principal\": \"*\",\n      \"Action\": \"*\"\n    }\n  ]\n}\n",
                                    "queue_url": "aws_sqs_queue.example_queue.id"
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