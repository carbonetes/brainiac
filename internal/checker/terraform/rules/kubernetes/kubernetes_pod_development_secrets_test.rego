package lib.terraform.CB_TFK8S_023

test_kubernetes_pod_development_secrets_passed {
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
                "Attributes": {
                    "replicas": "1"
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
                            "endLine": 17,
                            "startLine": 13
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
                                    "endLine": 24,
                                    "startLine": 20
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
                                                "Type": "env",
                                                "Labels": [],
                                                "Attributes": {
                                                    "name": "SECRET_KEY"
                                                },
                                                "Blocks": [
                                                    {
                                                        "Type": "value_from",
                                                        "Labels": [],
                                                        "Attributes": {},
                                                        "Blocks": [
                                                            {
                                                                "Type": "secret_key_ref",
                                                                "Labels": [],
                                                                "Attributes": {
                                                                    "key": "secret_key",
                                                                    "name": "example-secret"
                                                                },
                                                                "Blocks": [],
                                                                "line_range": {
                                                                    "endLine": 37,
                                                                    "startLine": 34
                                                                }
                                                            }
                                                        ],
                                                        "line_range": {
                                                            "endLine": 38,
                                                            "startLine": 33
                                                        }
                                                    }
                                                ],
                                                "line_range": {
                                                    "endLine": 39,
                                                    "startLine": 31
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 40,
                                            "startLine": 27
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 41,
                                    "startLine": 26
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 42,
                            "startLine": 19
                        }
                    }
                ],
                "line_range": {
                    "endLine": 43,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 5
        }
    }]
}

test_kubernetes_pod_development_secrets_failed {
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
                "Attributes": {
                    "replicas": "1"
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
                            "endLine": 17,
                            "startLine": 13
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
                                    "endLine": 24,
                                    "startLine": 20
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
                                                "Type": "env",
                                                "Labels": [],
                                                "Attributes": {
                                                    "name": "SECRET_KEY"
                                                },
                                                "Blocks": [],
                                                "line_range": {
                                                    "endLine": 39,
                                                    "startLine": 31
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 40,
                                            "startLine": 27
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 41,
                                    "startLine": 26
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 42,
                            "startLine": 19
                        }
                    }
                ],
                "line_range": {
                    "endLine": 43,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 5
        }
    }]
}