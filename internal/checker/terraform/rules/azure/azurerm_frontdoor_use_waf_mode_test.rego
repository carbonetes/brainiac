package lib.terraform.CB_TFAZR_126

test_azurerm_frontdoor_use_waf_mode_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-rg"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_frontdoor_firewall_policy",
                "example"
            ],
            "Attributes": {
                "custom_block_response_body": "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg==",
                "custom_block_response_status_code": "403",
                "enabled": true,
                "mode": "Prevention",
                "name": "examplefdwafpolicy",
                "redirect_url": "https://www.contoso.com",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "custom_rule",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "enabled": true,
                        "name": "Rule1",
                        "priority": "1",
                        "rate_limit_duration_in_minutes": "1",
                        "rate_limit_threshold": "10",
                        "type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_condition",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24",
                                    "10.0.0.0/24"
                                ],
                                "match_variable": "RemoteAddr",
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 29,
                                "startLine": 24
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 30,
                        "startLine": 15
                    }
                },
                {
                    "Type": "custom_rule",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "enabled": true,
                        "name": "Rule2",
                        "priority": "2",
                        "rate_limit_duration_in_minutes": "1",
                        "rate_limit_threshold": "10",
                        "type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_condition",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24"
                                ],
                                "match_variable": "RemoteAddr",
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 46,
                                "startLine": 41
                            }
                        },
                        {
                            "Type": "match_condition",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "windows"
                                ],
                                "match_variable": "RequestHeader",
                                "negation_condition": false,
                                "operator": "Contains",
                                "selector": "UserAgent",
                                "transforms": [
                                    "Lowercase",
                                    "Trim"
                                ]
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 55,
                                "startLine": 48
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 56,
                        "startLine": 32
                    }
                },
                {
                    "Type": "managed_rule",
                    "Labels": [],
                    "Attributes": {
                        "type": "DefaultRuleSet",
                        "version": "1.0"
                    },
                    "Blocks": [
                        {
                            "Type": "exclusion",
                            "Labels": [],
                            "Attributes": {
                                "match_variable": "QueryStringArgNames",
                                "operator": "Equals",
                                "selector": "not_suspicious"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 66,
                                "startLine": 62
                            }
                        },
                        {
                            "Type": "override",
                            "Labels": [],
                            "Attributes": {
                                "rule_group_name": "PHP"
                            },
                            "Blocks": [
                                {
                                    "Type": "rule",
                                    "Labels": [],
                                    "Attributes": {
                                        "action": "Block",
                                        "enabled": false,
                                        "rule_id": "933100"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 75,
                                        "startLine": 71
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 76,
                                "startLine": 68
                            }
                        },
                        {
                            "Type": "override",
                            "Labels": [],
                            "Attributes": {
                                "rule_group_name": "SQLI"
                            },
                            "Blocks": [
                                {
                                    "Type": "exclusion",
                                    "Labels": [],
                                    "Attributes": {
                                        "match_variable": "QueryStringArgNames",
                                        "operator": "Equals",
                                        "selector": "really_not_suspicious"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 85,
                                        "startLine": 81
                                    }
                                },
                                {
                                    "Type": "rule",
                                    "Labels": [],
                                    "Attributes": {
                                        "action": "Block",
                                        "rule_id": "942200"
                                    },
                                    "Blocks": [
                                        {
                                            "Type": "exclusion",
                                            "Labels": [],
                                            "Attributes": {
                                                "match_variable": "QueryStringArgNames",
                                                "operator": "Equals",
                                                "selector": "innocent"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 95,
                                                "startLine": 91
                                            }
                                        }
                                    ],
                                    "line_range": {
                                        "endLine": 96,
                                        "startLine": 87
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 97,
                                "startLine": 78
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 98,
                        "startLine": 58
                    }
                },
                {
                    "Type": "managed_rule",
                    "Labels": [],
                    "Attributes": {
                        "type": "Microsoft_BotManagerRuleSet",
                        "version": "1.0"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 103,
                        "startLine": 100
                    }
                },
                {
                    "Type": "policy_settings",
                    "Labels": [],
                    "Attributes": {
                        "enabled": true,
                        "file_upload_limit_in_mb": "100",
                        "max_request_body_size_in_kb": "128",
                        "mode": "Prevention",
                        "request_body_check": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 111,
                        "startLine": 105
                    }
                }
            ],
            "line_range": {
                "endLine": 112,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_frontdoor_use_waf_mode_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-rg"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_frontdoor_firewall_policy",
                "example"
            ],
            "Attributes": {
                "custom_block_response_body": "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg==",
                "custom_block_response_status_code": "403",
                "enabled": true,
                "mode": "Prevention",
                "name": "examplefdwafpolicy",
                "redirect_url": "https://www.contoso.com",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "custom_rule",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "enabled": true,
                        "name": "Rule1",
                        "priority": "1",
                        "rate_limit_duration_in_minutes": "1",
                        "rate_limit_threshold": "10",
                        "type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_condition",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24",
                                    "10.0.0.0/24"
                                ],
                                "match_variable": "RemoteAddr",
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 29,
                                "startLine": 24
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 30,
                        "startLine": 15
                    }
                },
                {
                    "Type": "custom_rule",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "enabled": true,
                        "name": "Rule2",
                        "priority": "2",
                        "rate_limit_duration_in_minutes": "1",
                        "rate_limit_threshold": "10",
                        "type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_condition",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24"
                                ],
                                "match_variable": "RemoteAddr",
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 46,
                                "startLine": 41
                            }
                        },
                        {
                            "Type": "match_condition",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "windows"
                                ],
                                "match_variable": "RequestHeader",
                                "negation_condition": false,
                                "operator": "Contains",
                                "selector": "UserAgent",
                                "transforms": [
                                    "Lowercase",
                                    "Trim"
                                ]
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 55,
                                "startLine": 48
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 56,
                        "startLine": 32
                    }
                },
                {
                    "Type": "managed_rule",
                    "Labels": [],
                    "Attributes": {
                        "type": "DefaultRuleSet",
                        "version": "1.0"
                    },
                    "Blocks": [
                        {
                            "Type": "exclusion",
                            "Labels": [],
                            "Attributes": {
                                "match_variable": "QueryStringArgNames",
                                "operator": "Equals",
                                "selector": "not_suspicious"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 66,
                                "startLine": 62
                            }
                        },
                        {
                            "Type": "override",
                            "Labels": [],
                            "Attributes": {
                                "rule_group_name": "PHP"
                            },
                            "Blocks": [
                                {
                                    "Type": "rule",
                                    "Labels": [],
                                    "Attributes": {
                                        "action": "Block",
                                        "enabled": false,
                                        "rule_id": "933100"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 75,
                                        "startLine": 71
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 76,
                                "startLine": 68
                            }
                        },
                        {
                            "Type": "override",
                            "Labels": [],
                            "Attributes": {
                                "rule_group_name": "SQLI"
                            },
                            "Blocks": [
                                {
                                    "Type": "exclusion",
                                    "Labels": [],
                                    "Attributes": {
                                        "match_variable": "QueryStringArgNames",
                                        "operator": "Equals",
                                        "selector": "really_not_suspicious"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 85,
                                        "startLine": 81
                                    }
                                },
                                {
                                    "Type": "rule",
                                    "Labels": [],
                                    "Attributes": {
                                        "action": "Block",
                                        "rule_id": "942200"
                                    },
                                    "Blocks": [
                                        {
                                            "Type": "exclusion",
                                            "Labels": [],
                                            "Attributes": {
                                                "match_variable": "QueryStringArgNames",
                                                "operator": "Equals",
                                                "selector": "innocent"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 95,
                                                "startLine": 91
                                            }
                                        }
                                    ],
                                    "line_range": {
                                        "endLine": 96,
                                        "startLine": 87
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 97,
                                "startLine": 78
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 98,
                        "startLine": 58
                    }
                },
                {
                    "Type": "managed_rule",
                    "Labels": [],
                    "Attributes": {
                        "type": "Microsoft_BotManagerRuleSet",
                        "version": "1.0"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 103,
                        "startLine": 100
                    }
                }
            ],
            "line_range": {
                "endLine": 112,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}