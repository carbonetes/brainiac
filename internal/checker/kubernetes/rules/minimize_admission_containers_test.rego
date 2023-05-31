package lib.kubernetes.CB_K8S_108

test_admission_containers_limited {
            result := passed with input as{						
                       "apiVersion": "v1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "<Pod name>"
                        },
                        "spec": {
                            "containers": [
                            {
                                "name": "<container name>",
                                "image": "<image>",
                                "securityContext": {
                                "capabilities": {
                                    "drop": [
                                    "ALL"
                                    ]
                                }
                                }
                            }
                            ]
                        }
				}

	count(result) == 1
}

test_admission_containers_no_limit {
            result := failed with input as{					
                      "apiVersion": "v1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "<Pod name>"
                        },
                        "spec": {
                            "containers": [
                            {
                                "name": "<container name>",
                                "image": "<image>",
                                "securityContext": {
                                "capabilities": {
                                    "drop": [
                                    
                                    ]
                                }
                                }
                            }
                            ]
                        }
				}

	count(result) == 1
}