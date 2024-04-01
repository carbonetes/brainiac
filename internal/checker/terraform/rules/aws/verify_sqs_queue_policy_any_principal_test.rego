package lib.terraform.CB_TFAWS_159
import rego.v1

test_verify_sqs_queue_policy_any_principal_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_sqs_queue_policy",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "policy": "{\n  \"Statement\":[\n      {\n        \"Principal\": \"*\",\n        \"Effect\": \"Deny\"\n      }\n  ]\n}\n",
                                    "name": "my-glacier-vault"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_sqs_queue_policy_any_principal_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_sqs_queue_policy",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "policy": "{\n  \"Statement\":[\n      {\n        \"Principal\": \"*\",\n        \"Effect\": \"Allow\"\n      }\n  ]\n}\n",
                                    "name": "my-glacier-vault"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}