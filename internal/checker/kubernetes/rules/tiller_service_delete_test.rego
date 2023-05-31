package lib.kubernetes.CB_K8S_029

test_inactive_tiller {
            result := passed with input as{						
                        "apiVersion": "v1",
                        "kind": "Service",
                        "metadata": {
                            "labels": {
                            "app": "helm",
                            "name": ""
                            },
                            "name": "",
                            "namespace": "kube-system"
                        },
                        "spec": {
                            "ports": [
                            {
                                "name": "tiller",
                                "port": 44134,
                                "protocol": "TCP",
                                "targetPort": "tiller"
                            }
                            ],
                            "selector": {
                            "app": "helm",
                            "name": ""
                            },
                            "type": "ClusterIP"
                        }
				}

	count(result) == 1
}

test_active_tiller {
            result := failed with input as{					
                         "apiVersion": "v1",
                        "kind": "Service",
                        "metadata": {
                            "labels": {
                            "app": "helm",
                            "name": "tiller"
                            },
                            "name": "tiller-deploy",
                            "namespace": "kube-system"
                        },
                        "spec": {
                            "ports": [
                            {
                                "name": "tiller",
                                "port": 44134,
                                "protocol": "TCP",
                                "targetPort": "tiller"
                            }
                            ],
                            "selector": {
                            "app": "helm",
                            "name": "tiller"
                            },
                            "type": "ClusterIP"
                        }
				}

	count(result) == 1
}