package lib.terraform.CB_TFAWS_016
import rego.v1

test_enable_dynamodb_pitr_passed if {
    result := passed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_dynamodb_table",
                                        "example_table"
                                    ],
                                    "Attributes": {
                                        "billing_mode": "PAY_PER_REQUEST",
                                        "hash_key": "id",
                                        "name": "example-table"
                                    },
                                    "Blocks": [
                                        {
                                            "Type": "attribute",
                                            "Labels": [],
                                            "Attributes": {
                                                "name": "id",
                                                "type": "S"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 8,
                                                "startLine": 5
                                            }
                                        },
                                        {
                                            "Type": "point_in_time_recovery",
                                            "Labels": [],
                                            "Attributes": {
                                                "enabled": true
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 12,
                                                "startLine": 10
                                            }
                                        }
                                    ],
                                    "line_range": {
                                        "endLine": 13,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}

test_enable_dynamodb_pitr_failed if {
result := failed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_dynamodb_table",
                                        "example_table"
                                    ],
                                    "Attributes": {
                                        "billing_mode": "PAY_PER_REQUEST",
                                        "hash_key": "id",
                                        "name": "example-table"
                                    },
                                    "Blocks": [
                                        {
                                            "Type": "attribute",
                                            "Labels": [],
                                            "Attributes": {
                                                "name": "id",
                                                "type": "S"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 8,
                                                "startLine": 5
                                            }
                                        },
                                        {
                                            "Type": "point_in_time_recovery",
                                            "Labels": [],
                                            "Attributes": {
                                                "enabled": false
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 12,
                                                "startLine": 10
                                            }
                                        }
                                    ],
                                    "line_range": {
                                        "endLine": 13,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}