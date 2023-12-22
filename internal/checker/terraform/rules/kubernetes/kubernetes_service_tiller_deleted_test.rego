package lib.terraform.CB_TFK8S_032

test_kubernetes_service_tiller_deleted_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_service",
            "tiller_service"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "labels": {
                        "app": "not-heml",
                        "name": "not-tiller"
                    },
                    "name": "tiller-deploy",
                    "namespace": "kube-system"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 2
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {
                    "selector": {
                        "app": "not-helm",
                        "name": "not-tiller"
                    },
                    "type": "ClusterIP"
                },
                "Blocks": [
                    {
                        "Type": "port",
                        "Labels": [],
                        "Attributes": {
                            "name": "tiller",
                            "port": "44134",
                            "protocol": "TCP",
                            "targetPort": "tiller"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 23,
                            "startLine": 18
                        }
                    }
                ],
                "line_range": {
                    "endLine": 26,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 27,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_kubernetes_service_tiller_deleted_failed {
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
                    "replicas": "3"
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
                                                "Type": "ports",
                                                "Labels": [],
                                                "Attributes": {
                                                    "container_port": "80"
                                                },
                                                "Blocks": [],
                                                "line_range": {
                                                    "endLine": 29,
                                                    "startLine": 27
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 30,
                                            "startLine": 23
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 31,
                                    "startLine": 22
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 32,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 33,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 34,
            "startLine": 1
        }
    }]
	count(result) == 1
}