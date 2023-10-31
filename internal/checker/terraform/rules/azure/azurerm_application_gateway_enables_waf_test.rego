package lib.terraform.CB_TFAZR_123

test_azurerm_application_gateway_enables_waf_passed {
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
                "azurerm_web_application_firewall_policy",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-wafpolicy",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "custom_rules",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "name": "Rule1",
                        "priority": "1",
                        "rule_type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_conditions",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24",
                                    "10.0.0.0/24"
                                ],
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [
                                {
                                    "Type": "match_variables",
                                    "Labels": [],
                                    "Attributes": {
                                        "variable_name": "RemoteAddr"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 19,
                                        "startLine": 17
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 24,
                                "startLine": 16
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 11
                    }
                },
                {
                    "Type": "custom_rules",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "name": "Rule2",
                        "priority": "2",
                        "rule_type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_conditions",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24"
                                ],
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [
                                {
                                    "Type": "match_variables",
                                    "Labels": [],
                                    "Attributes": {
                                        "variable_name": "RemoteAddr"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 37,
                                        "startLine": 35
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 42,
                                "startLine": 34
                            }
                        },
                        {
                            "Type": "match_conditions",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "Windows"
                                ],
                                "negation_condition": false,
                                "operator": "Contains"
                            },
                            "Blocks": [
                                {
                                    "Type": "match_variables",
                                    "Labels": [],
                                    "Attributes": {
                                        "selector": "UserAgent",
                                        "variable_name": "RequestHeaders"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 48,
                                        "startLine": 45
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 53,
                                "startLine": 44
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 56,
                        "startLine": 29
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
                        "endLine": 64,
                        "startLine": 58
                    }
                },
                {
                    "Type": "managed_rules",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [
                        {
                            "Type": "exclusion",
                            "Labels": [],
                            "Attributes": {
                                "match_variable": "RequestHeaderNames",
                                "selector": "x-company-secret-header",
                                "selector_match_operator": "Equals"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 71,
                                "startLine": 67
                            }
                        },
                        {
                            "Type": "exclusion",
                            "Labels": [],
                            "Attributes": {
                                "match_variable": "RequestCookieNames",
                                "selector": "too-tasty",
                                "selector_match_operator": "EndsWith"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 76,
                                "startLine": 72
                            }
                        },
                        {
                            "Type": "managed_rule_set",
                            "Labels": [],
                            "Attributes": {
                                "type": "OWASP",
                                "version": "3.2"
                            },
                            "Blocks": [
                                {
                                    "Type": "rule_group_override",
                                    "Labels": [],
                                    "Attributes": {
                                        "rule_group_name": "REQUEST-920-PROTOCOL-ENFORCEMENT"
                                    },
                                    "Blocks": [
                                        {
                                            "Type": "rule",
                                            "Labels": [],
                                            "Attributes": {
                                                "action": "Log",
                                                "enabled": true,
                                                "id": "920300"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 87,
                                                "startLine": 83
                                            }
                                        },
                                        {
                                            "Type": "rule",
                                            "Labels": [],
                                            "Attributes": {
                                                "action": "Block",
                                                "enabled": true,
                                                "id": "920440"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 93,
                                                "startLine": 89
                                            }
                                        }
                                    ],
                                    "line_range": {
                                        "endLine": 94,
                                        "startLine": 81
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 95,
                                "startLine": 78
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 96,
                        "startLine": 66
                    }
                }
            ],
            "line_range": {
                "endLine": 97,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_application_gateway_enables_waf_failed {
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
                "azurerm_web_application_firewall_policy",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-wafpolicy",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "custom_rules",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "name": "Rule1",
                        "priority": "1",
                        "rule_type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_conditions",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24",
                                    "10.0.0.0/24"
                                ],
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [
                                {
                                    "Type": "match_variables",
                                    "Labels": [],
                                    "Attributes": {
                                        "variable_name": "RemoteAddr"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 19,
                                        "startLine": 17
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 24,
                                "startLine": 16
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 11
                    }
                },
                {
                    "Type": "custom_rules",
                    "Labels": [],
                    "Attributes": {
                        "action": "Block",
                        "name": "Rule2",
                        "priority": "2",
                        "rule_type": "MatchRule"
                    },
                    "Blocks": [
                        {
                            "Type": "match_conditions",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "192.168.1.0/24"
                                ],
                                "negation_condition": false,
                                "operator": "IPMatch"
                            },
                            "Blocks": [
                                {
                                    "Type": "match_variables",
                                    "Labels": [],
                                    "Attributes": {
                                        "variable_name": "RemoteAddr"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 37,
                                        "startLine": 35
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 42,
                                "startLine": 34
                            }
                        },
                        {
                            "Type": "match_conditions",
                            "Labels": [],
                            "Attributes": {
                                "match_values": [
                                    "Windows"
                                ],
                                "negation_condition": false,
                                "operator": "Contains"
                            },
                            "Blocks": [
                                {
                                    "Type": "match_variables",
                                    "Labels": [],
                                    "Attributes": {
                                        "selector": "UserAgent",
                                        "variable_name": "RequestHeaders"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 48,
                                        "startLine": 45
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 53,
                                "startLine": 44
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 56,
                        "startLine": 29
                    }
                },
                {
                    "Type": "policy_settings",
                    "Labels": [],
                    "Attributes": {
                        "enabled": false,
                        "file_upload_limit_in_mb": "100",
                        "max_request_body_size_in_kb": "128",
                        "mode": "Prevention",
                        "request_body_check": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 64,
                        "startLine": 58
                    }
                },
                {
                    "Type": "managed_rules",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [
                        {
                            "Type": "exclusion",
                            "Labels": [],
                            "Attributes": {
                                "match_variable": "RequestHeaderNames",
                                "selector": "x-company-secret-header",
                                "selector_match_operator": "Equals"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 71,
                                "startLine": 67
                            }
                        },
                        {
                            "Type": "exclusion",
                            "Labels": [],
                            "Attributes": {
                                "match_variable": "RequestCookieNames",
                                "selector": "too-tasty",
                                "selector_match_operator": "EndsWith"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 76,
                                "startLine": 72
                            }
                        },
                        {
                            "Type": "managed_rule_set",
                            "Labels": [],
                            "Attributes": {
                                "type": "OWASP",
                                "version": "3.2"
                            },
                            "Blocks": [
                                {
                                    "Type": "rule_group_override",
                                    "Labels": [],
                                    "Attributes": {
                                        "rule_group_name": "REQUEST-920-PROTOCOL-ENFORCEMENT"
                                    },
                                    "Blocks": [
                                        {
                                            "Type": "rule",
                                            "Labels": [],
                                            "Attributes": {
                                                "action": "Log",
                                                "enabled": true,
                                                "id": "920300"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 87,
                                                "startLine": 83
                                            }
                                        },
                                        {
                                            "Type": "rule",
                                            "Labels": [],
                                            "Attributes": {
                                                "action": "Block",
                                                "enabled": true,
                                                "id": "920440"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                                "endLine": 93,
                                                "startLine": 89
                                            }
                                        }
                                    ],
                                    "line_range": {
                                        "endLine": 94,
                                        "startLine": 81
                                    }
                                }
                            ],
                            "line_range": {
                                "endLine": 95,
                                "startLine": 78
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 96,
                        "startLine": 66
                    }
                }
            ],
            "line_range": {
                "endLine": 97,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}