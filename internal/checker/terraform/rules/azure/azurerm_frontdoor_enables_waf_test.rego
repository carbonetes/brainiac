package lib.terraform.CB_TFAZR_124

test_azurerm_frontdoor_enables_waf_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "FrontDoorExampleResourceGroup"
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
                "azurerm_frontdoor",
                "example"
            ],
            "Attributes": {
                "name": "example-FrontDoor",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "routing_rule",
                    "Labels": [],
                    "Attributes": {
                        "accepted_protocols": [
                            "Http",
                            "Https"
                        ],
                        "frontend_endpoints": [
                            "exampleFrontendEndpoint1"
                        ],
                        "name": "exampleRoutingRule1",
                        "patterns_to_match": [
                            "/*"
                        ]
                    },
                    "Blocks": [
                        {
                            "Type": "forwarding_configuration",
                            "Labels": [],
                            "Attributes": {
                                "backend_pool_name": "exampleBackendBing",
                                "forwarding_protocol": "MatchRequest"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 18,
                                "startLine": 15
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 10
                    }
                },
                {
                    "Type": "backend_pool_load_balancing",
                    "Labels": [],
                    "Attributes": {
                        "name": "exampleLoadBalancingSettings1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 23,
                        "startLine": 21
                    }
                },
                {
                    "Type": "backend_pool_health_probe",
                    "Labels": [],
                    "Attributes": {
                        "name": "exampleHealthProbeSetting1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 25
                    }
                },
                {
                    "Type": "backend_pool",
                    "Labels": [],
                    "Attributes": {
                        "health_probe_name": "exampleHealthProbeSetting1",
                        "load_balancing_name": "exampleLoadBalancingSettings1",
                        "name": "exampleBackendBing"
                    },
                    "Blocks": [
                        {
                            "Type": "backend",
                            "Labels": [],
                            "Attributes": {
                                "address": "www.bing.com",
                                "host_header": "www.bing.com",
                                "http_port": "80",
                                "https_port": "443"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 36,
                                "startLine": 31
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 40,
                        "startLine": 29
                    }
                },
                {
                    "Type": "frontend_endpoint",
                    "Labels": [],
                    "Attributes": {
                        "host_name": "example-FrontDoor.azurefd.net",
                        "name": "exampleFrontendEndpoint1",
                        "web_application_firewall_policy_link_id": "sample_web_application_firewall_policy_link_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 46,
                        "startLine": 42
                    }
                }
            ],
            "line_range": {
                "endLine": 47,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_frontdoor_enables_waf_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "FrontDoorExampleResourceGroup"
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
                "azurerm_frontdoor",
                "example"
            ],
            "Attributes": {
                "name": "example-FrontDoor",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "routing_rule",
                    "Labels": [],
                    "Attributes": {
                        "accepted_protocols": [
                            "Http",
                            "Https"
                        ],
                        "frontend_endpoints": [
                            "exampleFrontendEndpoint1"
                        ],
                        "name": "exampleRoutingRule1",
                        "patterns_to_match": [
                            "/*"
                        ]
                    },
                    "Blocks": [
                        {
                            "Type": "forwarding_configuration",
                            "Labels": [],
                            "Attributes": {
                                "backend_pool_name": "exampleBackendBing",
                                "forwarding_protocol": "MatchRequest"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 18,
                                "startLine": 15
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 10
                    }
                },
                {
                    "Type": "backend_pool_load_balancing",
                    "Labels": [],
                    "Attributes": {
                        "name": "exampleLoadBalancingSettings1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 23,
                        "startLine": 21
                    }
                },
                {
                    "Type": "backend_pool_health_probe",
                    "Labels": [],
                    "Attributes": {
                        "name": "exampleHealthProbeSetting1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 25
                    }
                },
                {
                    "Type": "backend_pool",
                    "Labels": [],
                    "Attributes": {
                        "health_probe_name": "exampleHealthProbeSetting1",
                        "load_balancing_name": "exampleLoadBalancingSettings1",
                        "name": "exampleBackendBing"
                    },
                    "Blocks": [
                        {
                            "Type": "backend",
                            "Labels": [],
                            "Attributes": {
                                "address": "www.bing.com",
                                "host_header": "www.bing.com",
                                "http_port": "80",
                                "https_port": "443"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 36,
                                "startLine": 31
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 40,
                        "startLine": 29
                    }
                },
                {
                    "Type": "frontend_endpoint",
                    "Labels": [],
                    "Attributes": {
                        "host_name": "example-FrontDoor.azurefd.net",
                        "name": "exampleFrontendEndpoint1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 46,
                        "startLine": 42
                    }
                }
            ],
            "line_range": {
                "endLine": 47,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}