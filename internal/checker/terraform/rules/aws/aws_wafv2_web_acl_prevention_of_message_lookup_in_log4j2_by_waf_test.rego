package lib.terraform.CB_TFAWS_183
import rego.v1

test_aws_wafv2_web_acl_prevention_of_message_lookup_in_log4j2_by_waf_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_wafv2_web_acl",
                        "sample"
                        ],
                        "Attributes": {},
                        "Blocks": [
                        {
                            "Type": "rule",
                            "Labels": [],
                            "Attributes": {
                            "name": "AWS-AWSManagedRulesKnownBadInputsRuleSet",
                            "priority": "1"
                            },
                            "Blocks": [
                            {
                            "Type": "override_action",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                            {
                                "Type": "none",
                                "Labels": [],
                                "Attributes": {},
                                "Blocks": [],
                                "line_range": {
                                "endLine": 7,
                                "startLine": 7
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 8,
                            "startLine": 6
                            }
                            },
                            {
                            "Type": "statement",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                            {
                                "Type": "managed_rule_group_statement",
                                "Labels": [],
                                "Attributes": {
                                "name": "AWSManagedRulesKnownBadInputsRuleSet",
                                "vendor_name": "AWS"
                                },
                                "Blocks": [
                                {
                                "Type": "excluded_rule",
                                "Labels": [],
                                "Attributes": {
                                "name": "sample_name"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 17,
                                "startLine": 15
                                }
                                }
                                ],
                                "line_range": {
                                "endLine": 18,
                                "startLine": 11
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 19,
                            "startLine": 10
                            }
                            }
                            ],
                            "line_range": {
                            "endLine": 20,
                            "startLine": 2
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 21,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_wafv2_web_acl_prevention_of_message_lookup_in_log4j2_by_waf_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_wafv2_web_acl",
                        "sample"
                        ],
                        "Attributes": {},
                        "Blocks": [
                        {
                            "Type": "rule",
                            "Labels": [],
                            "Attributes": {
                            "name": "AWS-AWSManagedRulesKnownBadInputsRuleSet",
                            "priority": "1"
                            },
                            "Blocks": [
                            {
                            "Type": "override_action",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                            {
                                "Type": "count",
                                "Labels": [],
                                "Attributes": {},
                                "Blocks": [],
                                "line_range": {
                                "endLine": 7,
                                "startLine": 7
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 8,
                            "startLine": 6
                            }
                            },
                            {
                            "Type": "statement",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                            {
                                "Type": "managed_rule_group_statement",
                                "Labels": [],
                                "Attributes": {
                                "name": "other_name",
                                "vendor_name": "AWS"
                                },
                                "Blocks": [
                                {
                                "Type": "excluded_rule",
                                "Labels": [],
                                "Attributes": {
                                "name": "Log4JRCE"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 17,
                                "startLine": 15
                                }
                                }
                                ],
                                "line_range": {
                                "endLine": 18,
                                "startLine": 11
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 19,
                            "startLine": 10
                            }
                            }
                            ],
                            "line_range": {
                            "endLine": 20,
                            "startLine": 2
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 21,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}