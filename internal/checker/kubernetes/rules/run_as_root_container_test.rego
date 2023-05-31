package lib.kubernetes.CB_K8S_068

test_not_root_container {
            result := passed with input as{						
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "runAsUser": null,
                            "rule": "MustRunAs",
                            "ranges": [
                            {
                                "min": 0,
                                "max": "<max user>"
                            }
                            ]
                        }
				}

	count(result) == 1
}

test_root_container{
            result := failed with input as{					
                      "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "runAsUser": null,
                            "rule": "MustRunAs",
                            "ranges": [
                            {
                                "min": -1,
                                "max": "<max user>"
                            }
                            ]
                        }
				}

	count(result) == 1
}