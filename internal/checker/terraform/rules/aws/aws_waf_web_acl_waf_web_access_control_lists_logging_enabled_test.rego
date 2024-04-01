package lib.terraform.CB_TFAWS_167
import rego.v1

test_aws_waf_web_acl_waf_web_access_control_lists_logging_enabled_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_waf_web_acl",
                        "example"
                        ],
                        "Attributes": {},
                        "Blocks": [
                        {
                            "Type": "logging_configuration",
                            "Labels": [],
                            "Attributes": {
                            "log_destination": "aws_kinesis_firehose_delivery_stream.example.arn"
                            },
                            "Blocks": [
                            {
                            "Type": "redacted_fields",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                            {
                                "Type": "field_to_match",
                                "Labels": [],
                                "Attributes": {
                                "type": "URI"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 9,
                                "startLine": 7
                                }
                            },
                            {
                                "Type": "field_to_match",
                                "Labels": [],
                                "Attributes": {
                                "data": "referer",
                                "type": "HEADER"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 14,
                                "startLine": 11
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 15,
                            "startLine": 6
                            }
                            }
                            ],
                            "line_range": {
                            "endLine": 16,
                            "startLine": 3
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 17,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_waf_web_acl_waf_web_access_control_lists_logging_enabled_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_waf_web_acl",
                        "example"
                        ],
                        "Attributes": {},
                        "Blocks": [
                        {
                            "Type": "logging_configuration",
                            "Labels": [],
                            "Attributes": {
                            "log_destination": ""
                            },
                            "Blocks": [
                            {
                            "Type": "redacted_fields",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                            {
                                "Type": "field_to_match",
                                "Labels": [],
                                "Attributes": {
                                "type": "URI"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 9,
                                "startLine": 7
                                }
                            },
                            {
                                "Type": "field_to_match",
                                "Labels": [],
                                "Attributes": {
                                "data": "referer",
                                "type": "HEADER"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 14,
                                "startLine": 11
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 15,
                            "startLine": 6
                            }
                            }
                            ],
                            "line_range": {
                            "endLine": 16,
                            "startLine": 3
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 17,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}