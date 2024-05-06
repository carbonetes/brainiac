package lib.terraform.CB_TFAWS_163
import rego.v1

test_aws_wafv2_web_acl_waf_associated_rules_passed if {
    result := passed with input as [
                        {
                    "Type": "resource",
                    "Labels": [
                    "aws_wafv2_web_acl",
                    "example"
                    ],
                    "Attributes": {
                    "description": "Example of a managed rule.",
                    "name": "managed-rule-example",
                    "scope": "REGIONAL",
                    "tags": {
                        "Tag1": "Value1",
                        "Tag2": "Value2"
                    }
                    },
                    "Blocks": [
                    {
                        "Type": "default_action",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                        {
                        "Type": "allow",
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
                        "Type": "rule",
                        "Labels": [],
                        "Attributes": {
                        "name": "rule-1",
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
                            "endLine": 15,
                            "startLine": 15
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 16,
                        "startLine": 14
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
                            "name": "AWSManagedRulesCommonRuleSet",
                            "vendor_name": "AWS"
                            },
                            "Blocks": [
                            {
                            "Type": "excluded_rule",
                            "Labels": [],
                            "Attributes": {
                            "name": "SizeRestrictions_QUERYSTRING"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 25,
                            "startLine": 23
                            }
                            },
                            {
                            "Type": "excluded_rule",
                            "Labels": [],
                            "Attributes": {
                            "name": "NoUserAgent_HEADER"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 29,
                            "startLine": 27
                            }
                            },
                            {
                            "Type": "scope_down_statement",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                            {
                                "Type": "geo_match_statement",
                                "Labels": [],
                                "Attributes": {
                                "country_codes": [
                                "US",
                                "NL"
                                ]
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 34,
                                "startLine": 32
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 35,
                            "startLine": 31
                            }
                            }
                            ],
                            "line_range": {
                            "endLine": 36,
                            "startLine": 19
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 37,
                        "startLine": 18
                        }
                        },
                        {
                        "Type": "visibility_config",
                        "Labels": [],
                        "Attributes": {
                        "cloudwatch_metrics_enabled": false,
                        "metric_name": "friendly-rule-metric-name",
                        "sampled_requests_enabled": false
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 43,
                        "startLine": 39
                        }
                        }
                        ],
                        "line_range": {
                        "endLine": 44,
                        "startLine": 10
                        }
                    },
                    {
                        "Type": "visibility_config",
                        "Labels": [],
                        "Attributes": {
                        "cloudwatch_metrics_enabled": false,
                        "metric_name": "friendly-metric-name",
                        "sampled_requests_enabled": false
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 55,
                        "startLine": 51
                        }
                    }
                    ],
                    "line_range": {
                    "endLine": 56,
                    "startLine": 1
                    }
                    }
                        ]
    count(result) == 1
}

test_aws_wafv2_web_acl_waf_associated_rules_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": ["aws_wafv2_web_acl", "example"],
                        "Attributes": {
                            "description": "Example of a managed rule.",
                            "name": "managed-rule-example",
                            "scope": "REGIONAL",
                            "tags": {
                            "Tag1": "Value1",
                            "Tag2": "Value2"
                            }
                        },
                        "Blocks": [
                            {
                            "Type": "default_action",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [
                                {
                                "Type": "allow",
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
                            }
                        ],
                        "line_range": {
                            "endLine": 9,
                            "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}