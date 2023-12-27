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
                        "app": "helm",
                        "name": "tiller"
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
                        "app": "helm",
                        "name": "tiller"
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