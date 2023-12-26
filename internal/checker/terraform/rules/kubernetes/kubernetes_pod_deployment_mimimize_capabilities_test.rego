package lib.terraform.CB_TFK8S_027

test_kubernetes_pod_deployment_mimimize_capabilities_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_deployment",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "example-deployment"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {
                    "replicas": "2"
                },
                "Blocks": [
                    {
                        "Type": "selector",
                        "Labels": [],
                        "Attributes": {
                            "match_labels": {
                                "app": "example"
                            }
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 13,
                            "startLine": 9
                        }
                    },
                    {
                        "Type": "template",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "metadata",
                                "Labels": [],
                                "Attributes": {
                                    "labels": {
                                        "app": "example"
                                    }
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 20,
                                    "startLine": 16
                                }
                            },
                            {
                                "Type": "spec",
                                "Labels": [],
                                "Attributes": {},
                                "Blocks": [
                                    {
                                        "Type": "container",
                                        "Labels": [],
                                        "Attributes": {
                                            "image": "nginx:latest",
                                            "name": "example-container"
                                        },
                                        "Blocks": [
                                            {
                                                "Type": "security_context",
                                                "Labels": [],
                                                "Attributes": {},
                                                "Blocks": [
                                                    {
                                                        "Type": "capabilities",
                                                        "Labels": [],
                                                        "Attributes": {
                                                            "drop": [
                                                                "SYS_ADMIN"
                                                            ]
                                                        },
                                                        "Blocks": [],
                                                        "line_range": {
                                                            "endLine": 30,
                                                            "startLine": 28
                                                        }
                                                    }
                                                ],
                                                "line_range": {
                                                    "endLine": 31,
                                                    "startLine": 27
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 32,
                                            "startLine": 23
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 33,
                                    "startLine": 22
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 36,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_kubernetes_pod_deployment_mimimize_capabilities_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_deployment",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "example-deployment"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {
                    "replicas": "2"
                },
                "Blocks": [
                    {
                        "Type": "selector",
                        "Labels": [],
                        "Attributes": {
                            "match_labels": {
                                "app": "example"
                            }
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 13,
                            "startLine": 9
                        }
                    },
                    {
                        "Type": "template",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "metadata",
                                "Labels": [],
                                "Attributes": {
                                    "labels": {
                                        "app": "example"
                                    }
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 20,
                                    "startLine": 16
                                }
                            },
                            {
                                "Type": "spec",
                                "Labels": [],
                                "Attributes": {},
                                "Blocks": [
                                    {
                                        "Type": "container",
                                        "Labels": [],
                                        "Attributes": {
                                            "image": "nginx:latest",
                                            "name": "example-container"
                                        },
                                        "Blocks": [
                                            {
                                                "Type": "security_context",
                                                "Labels": [],
                                                "Attributes": {},
                                                "Blocks": [
                                                    {
                                                        "Type": "capabilities",
                                                        "Labels": [],
                                                        "Attributes": {
                                                            "drop": [
                                                                "ALL"
                                                            ]
                                                        },
                                                        "Blocks": [],
                                                        "line_range": {
                                                            "endLine": 30,
                                                            "startLine": 28
                                                        }
                                                    }
                                                ],
                                                "line_range": {
                                                    "endLine": 31,
                                                    "startLine": 27
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 32,
                                            "startLine": 23
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 33,
                                    "startLine": 22
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 36,
            "startLine": 1
        }
    }]
	count(result) == 1
}
