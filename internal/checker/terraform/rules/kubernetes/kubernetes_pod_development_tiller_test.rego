package lib.terraform.CB_TFK8S_019

test_kubernetes_pod_development_tiller_passed {
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
                    "labels": {
                        "app": "helm"
                    },
                    "name": "example-deployment"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 2
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
                                "app": "helm"
                            }
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 18,
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
                                        "app": "helm2",
                                        "name": "tiller2"
                                    }
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 26,
                                    "startLine": 21
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
                                            "image": "alpine",
                                            "name": "example-container"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                            "endLine": 33,
                                            "startLine": 29
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 34,
                                    "startLine": 28
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 35,
                            "startLine": 20
                        }
                    }
                ],
                "line_range": {
                    "endLine": 36,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 1
        }
    }]
}

test_kubernetes_pod_development_tiller_failed {
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
                    "labels": {
                        "app": "helm"
                    },
                    "name": "example-deployment"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 2
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
                                "app": "helm"
                            }
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 18,
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
                                        "app": "helm",
                                        "name": "tiller"
                                    }
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 26,
                                    "startLine": 21
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
                                            "image": "not-tiller-image:tag",
                                            "name": "example-container"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                            "endLine": 33,
                                            "startLine": 29
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 34,
                                    "startLine": 28
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 35,
                            "startLine": 20
                        }
                    }
                ],
                "line_range": {
                    "endLine": 36,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 1
        }
    }]
}