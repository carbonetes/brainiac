package lib.terraform.CB_TFK8S_012

test_kubernetes_pod_development_drop_capabilities_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "kubernetes"
        ],
        "Attributes": {
            "config_path": "~/.kube/config"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
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
                    "endLine": 8,
                    "startLine": 6
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {},
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
                            "endLine": 15,
                            "startLine": 11
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
                                    "endLine": 22,
                                    "startLine": 18
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
                                            "name": "nginx"
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
                                                            "endLine": 32,
                                                            "startLine": 30
                                                        }
                                                    }
                                                ],
                                                "line_range": {
                                                    "endLine": 33,
                                                    "startLine": 29
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 34,
                                            "startLine": 25
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 35,
                                    "startLine": 24
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 36,
                            "startLine": 17
                        }
                    }
                ],
                "line_range": {
                    "endLine": 37,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 38,
            "startLine": 5
        }
    }]
}

test_kubernetes_pod_development_drop_capabilities_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "kubernetes"
        ],
        "Attributes": {
            "config_path": "~/.kube/config"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
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
                    "endLine": 8,
                    "startLine": 6
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {},
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
                            "endLine": 15,
                            "startLine": 11
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
                                    "endLine": 22,
                                    "startLine": 18
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
                                            "name": "nginx"
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
                                                                "NET_RAW"
                                                            ]
                                                        },
                                                        "Blocks": [],
                                                        "line_range": {
                                                            "endLine": 32,
                                                            "startLine": 30
                                                        }
                                                    }
                                                ],
                                                "line_range": {
                                                    "endLine": 33,
                                                    "startLine": 29
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 34,
                                            "startLine": 25
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 35,
                                    "startLine": 24
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 36,
                            "startLine": 17
                        }
                    }
                ],
                "line_range": {
                    "endLine": 37,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 38,
            "startLine": 5
        }
    }]
}
